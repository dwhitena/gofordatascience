package main

import (
	"encoding/csv"
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

func main() {

	csvfile, err := os.Open("/pfs/repodata/repodata.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer csvfile.Close()

	reader := csv.NewReader(csvfile)
	reader.FieldsPerRecord = -1
	rawCSVdata, err := reader.ReadAll()
	if err != nil {
		log.Fatal(err)
	}

	count := 0
	for _, each := range rawCSVdata {
		intString := strconv.Itoa(count)
		d1 := []byte(each[0])
		err = ioutil.WriteFile("/pfs/out/"+intString, d1, 0644)
		if err != nil {
			log.Fatal(err)
		}
		count++
	}
}
