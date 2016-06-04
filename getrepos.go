package main

import (
	"fmt"
	"log"
	"math"
	"time"

	"github.com/google/go-github/github"
)

const (
	REMAINING_THRESHOLD = 1
)

func main() {

	client := github.NewClient(nil)

	// start time
	t1 := time.Date(2013, time.January, 1, 0, 0, 0, 0, time.UTC)

	for t1.Unix() < time.Now().Unix() {

		t2 := t1.Add(time.Hour * 24 * 2)
		tString := fmt.Sprintf("\"%d-%02d-%02d .. %d-%02d-%02d\"",
			t1.Year(), t1.Month(), t1.Day(),
			t2.Year(), t2.Month(), t2.Day())

		query := fmt.Sprintf("language:Go created:" + tString)

		page := 1
		maxPage := math.MaxInt32

		opts := &github.SearchOptions{
			Sort:  "stars",
			Order: "desc",
			ListOptions: github.ListOptions{
				PerPage: 100,
			},
		}

		for page <= maxPage {
			opts.Page = page
			result, response, err := client.Search.Repositories(query, opts)
			Wait(response)

			if err != nil {
				log.Fatal("FindRepos:", err)
			}

			maxPage = response.LastPage

			msg := fmt.Sprintf("query: %s, page: %v/%v, size: %v, total: %v",
				tString, page, maxPage, len(result.Repositories), *result.Total)
			log.Println(msg)

			for _, repo := range result.Repositories {

				name := *repo.FullName
				updated_at := repo.UpdatedAt.String()
				created_at := repo.CreatedAt.String()
				forks := *repo.ForksCount
				issues := *repo.OpenIssuesCount
				stars := *repo.StargazersCount
				size := *repo.Size

				fmt.Printf("%s,%s,%s,%d,%d,%d,%d\n",
					name, updated_at, created_at, forks, issues, stars, size)

			}

			time.Sleep(time.Second * 10)
			page++

		}

		t1 = t1.Add(time.Hour * 24 * 2)

	}

}

func Wait(response *github.Response) {
	if response != nil && response.Remaining <= REMAINING_THRESHOLD {
		gap := time.Duration(response.Reset.Local().Unix() - time.Now().Unix())
		sleep := gap * time.Second
		if sleep < 0 {
			sleep = -sleep
		}

		time.Sleep(sleep)
	}
}
