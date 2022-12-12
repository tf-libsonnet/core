package test

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/google/go-jsonnet"
	"github.com/gruntwork-io/terratest/modules/terraform"
	. "github.com/onsi/gomega"
)

const (
	unitTestFixtureDir = "fixtures/tfunit"
)

func TestUnitVariableDefaultRequired(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	variablePath := filepath.Join(unitTestFixtureDir, "variable")
	jsonnetFPath := filepath.Join(variablePath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, nil)
	g.Expect(err).To(HaveOccurred())
}

func TestUnitVariableWithInput(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	variablePath := filepath.Join(unitTestFixtureDir, "variable")
	jsonnetFPath := filepath.Join(variablePath, "main.tf.jsonnet")
	err := renderAndApplyE(
		t,
		jsonnetFPath,
		map[string]interface{}{
			"required_input": "pass in",
		},
		nil,
	)
	g.Expect(err).NotTo(HaveOccurred())
}

func TestUnitVariableWithType(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	variablePath := filepath.Join(unitTestFixtureDir, "variable")
	jsonnetFPath := filepath.Join(variablePath, "main.tf.jsonnet")
	err := renderAndApplyE(
		t,
		jsonnetFPath,
		map[string]interface{}{
			"required_input":  "pass in",
			"optional_number": "not-a-number",
		},
		nil,
	)
	g.Expect(err).To(HaveOccurred())

	withNumberErr := renderAndApplyE(
		t,
		jsonnetFPath,
		map[string]interface{}{
			"required_input":  "pass in",
			"optional_number": 1337,
		},
		nil,
	)
	g.Expect(withNumberErr).NotTo(HaveOccurred())
}

func TestUnitResource(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	resourcePath := filepath.Join(unitTestFixtureDir, "resource")
	jsonnetFPath := filepath.Join(resourcePath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, nil)
	g.Expect(err).NotTo(HaveOccurred())
}

func TestUnitOutput(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	var out struct {
		Msg string
	}

	outputPath := filepath.Join(unitTestFixtureDir, "output")
	jsonnetFPath := filepath.Join(outputPath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, &out)
	g.Expect(err).NotTo(HaveOccurred())
	g.Expect(out.Msg).To(Equal("hello world"))
}

func TestUnitLocal(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	var out struct {
		Msg string
	}

	localPath := filepath.Join(unitTestFixtureDir, "local")
	jsonnetFPath := filepath.Join(localPath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, &out)
	g.Expect(err).NotTo(HaveOccurred())
	g.Expect(out.Msg).To(Equal("hello world"))
}

func TestUnitData(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	var out struct {
		Msg string
	}

	dataPath := filepath.Join(unitTestFixtureDir, "data")
	jsonnetFPath := filepath.Join(dataPath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, &out)
	g.Expect(err).NotTo(HaveOccurred())
	g.Expect(out.Msg).To(Equal("hello world"))
}

func TestUnitRef(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	var out struct {
		Msg            string
		NullResourceID string `json:"null_resource_id"`
	}

	refPath := filepath.Join(unitTestFixtureDir, "ref")
	jsonnetFPath := filepath.Join(refPath, "main.tf.jsonnet")
	err := renderAndApplyE(t, jsonnetFPath, nil, &out)
	g.Expect(err).NotTo(HaveOccurred())
	g.Expect(out.Msg).To(Equal("hello world"))
	g.Expect(out.NullResourceID).NotTo(Equal(""))
}

func renderAndApplyE(
	t *testing.T,
	jsonnetFPath string,
	vars map[string]interface{},
	outputStruct interface{},
) error {
	g := NewGomegaWithT(t)

	rootPath, err := filepath.Abs("..")
	g.Expect(err).ToNot(HaveOccurred())

	tmpDir, err := os.MkdirTemp("", "tf-libsonnet-test-*")
	g.Expect(err).ToNot(HaveOccurred())
	defer os.RemoveAll(tmpDir)

	vm := jsonnet.MakeVM()
	importer := jsonnet.FileImporter{
		JPaths: []string{rootPath},
	}
	vm.Importer(&importer)
	rendered, err := vm.EvaluateFile(jsonnetFPath)
	g.Expect(err).ToNot(HaveOccurred())

	writeErr := os.WriteFile(filepath.Join(tmpDir, "main.tf.json"), []byte(rendered), 0o644)
	g.Expect(writeErr).ToNot(HaveOccurred())

	tfOpts := &terraform.Options{
		TerraformDir: tmpDir,
		Vars:         vars,
		NoColor:      true,
	}
	_, applyErr := terraform.InitAndApplyE(t, tfOpts)
	if applyErr != nil {
		return applyErr
	}

	if outputStruct != nil {
		terraform.OutputStruct(t, tfOpts, "output", outputStruct)
	}
	return nil
}
