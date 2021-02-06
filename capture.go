// +build ignore

package main

import (
	"io/ioutil"
	"os"
)


//openwrt router
//GOOS=linux GOARCH=mips GOMIPS=softfloat go build -trimpath -ldflags="-s -w" -o hellor-arm  hello.go



func main() {
	data, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		panic(err)
	}

	err = ioutil.WriteFile("/tmp/data.in", data, 0644)
	if err != nil {
		panic(err)
	}

	{
		f, err := os.Create("/tmp/data.args")
		if err != nil {
			panic(err)
		}
		defer f.Close()
		for _, arg := range os.Args {
			f.WriteString(arg)
			f.WriteString("\n")
		}
		f.Sync()
	}


	{
		f, err := os.Create("/tmp/data.env")
		if err != nil {
			panic(err)
		}
		defer f.Close()
		for _, env := range os.Environ() {
			f.WriteString(env)
			f.WriteString("\n")
		}
		f.Sync()
	}

}
