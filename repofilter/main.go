package main

import (
	"encoding/csv"
	"io/ioutil"
	"log"
	"os"
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

	for _, each := range rawCSVdata {
		d1 := []byte(each[0])
		err = ioutil.WriteFile("/pfs/out/"+each[0], d1, 0644)
		if err != nil {
			log.Fatal(err)
		}
	}
}
