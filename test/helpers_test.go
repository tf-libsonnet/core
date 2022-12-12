package test

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/google/go-jsonnet"
	. "github.com/onsi/gomega"
)

const (
	helpersFixtureDir = "fixtures/helpers"
)

func TestHelpers(t *testing.T) {
	t.Parallel()
	g := NewGomegaWithT(t)

	rootPath, err := filepath.Abs("..")
	g.Expect(err).ToNot(HaveOccurred())

	dir, err := os.Open(helpersFixtureDir)
	g.Expect(err).ToNot(HaveOccurred())
	defer dir.Close()

	testCases, err := dir.Readdir(0)
	g.Expect(err).ToNot(HaveOccurred())

	for _, tc := range testCases {
		tc := tc
		t.Run(tc.Name(), func(t *testing.T) {
			t.Parallel()
			g := NewGomegaWithT(t)

			tcPath := filepath.Join(helpersFixtureDir, tc.Name())
			jsonnetFPath := filepath.Join(tcPath, "test.jsonnet")
			expectedJSONPath := filepath.Join(tcPath, "expected.json")
			expectedJSON, err := os.ReadFile(expectedJSONPath)
			g.Expect(err).ToNot(HaveOccurred())

			vm := jsonnet.MakeVM()
			importer := jsonnet.FileImporter{
				JPaths: []string{rootPath},
			}
			vm.Importer(&importer)
			actual, err := vm.EvaluateFile(jsonnetFPath)
			g.Expect(err).ToNot(HaveOccurred())
			g.Expect(actual).To(Equal(string(expectedJSON)))
		})
	}
}
