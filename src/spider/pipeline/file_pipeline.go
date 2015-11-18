package pipeline

import (
	"os"
	"spider/util"
)

type FilePipeline struct {
	file     *os.File
	splitter string
}

func NewFilePipeline(file *os.File, splitter string) *FilePipeline {
	p := &FilePipeline{file: file, splitter: splitter}
	return p
}

func (this *FilePipeline) Pipe(items *util.Items) {
	for k, v := range items.GetAll() {
		this.file.WriteString(k + this.splitter + v + "\n")
	}
}
