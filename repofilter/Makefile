all: compile docker

compile:
		CGO_ENABLED=0 go build -o repofilter

docker:
		sudo docker build --force-rm=true -t dwhitena/repofilter .
