
.PHONY: build
build:
	go build cmd/fakeps/fakeps.go


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32:
	GOOS=windows GOARCH=amd64 go build -o fakeps_32.exe cmd/fakeps/fakeps.go

.PHONY: build-win64
build-win64:
	GOOS=windows GOARCH=amd64 go build -o fakeps_64.exe cmd/fakeps/fakeps.go

.PHONY: build-mac
build-mac:
	GOOS=darwin GOARCH=amd64 go build -o fakeps_mac cmd/fakeps/fakeps.go

.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build -o fakeps_linux cmd/fakeps/fakeps.go


.PHONY: worker
worker:
	-mkdir -p build
	GOOS=linux GOARCH=amd64 go build -o build/worker_linux cmd/worker/worker.go
	GOOS=darwin GOARCH=amd64 go build -o build/fakeps_mac cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/fakeps_64.exe cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/fakeps_32.exe cmd/worker/worker.go


.PHONY: clean
clean:
	-rm -rf build/
	-rm -f fakeps fakeps_*

