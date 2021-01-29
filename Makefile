
.PHONY: build
build: prepare
	go build -o build/worker cmd/worker/worker.go
	go build cmd/fakeps/fakeps.go


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32: prepare
	GOOS=windows GOARCH=386 go build -o build/worker cmd/worker/worker.go
	GOOS=windows GOARCH=386 go build -o build/fakeps_win32.exe cmd/fakeps/fakeps.go

.PHONY: build-win64
build-win64: prepare
	GOOS=windows GOARCH=amd64 go build -o build/worker cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/fakeps_win64.exe cmd/fakeps/fakeps.go

.PHONY: build-mac
build-mac: prepare
	GOOS=darwin GOARCH=amd64 go build -o build/worker cmd/worker/worker.go
	GOOS=darwin GOARCH=amd64 go build -o build/fakeps_darwin cmd/fakeps/fakeps.go

.PHONY: build-linux
build-linux: prepare
	GOOS=linux GOARCH=amd64 go build -o build/worker cmd/worker/worker.go
	GOOS=linux GOARCH=amd64 go build -o build/fakeps_linux cmd/fakeps/fakeps.go


.PHONY: prepare
prepare:
	-mkdir -p build

.PHONY: worker
worker: prepare
	go build -o build/worker cmd/worker/worker.go


.PHONY: clean
clean:
	-rm -rf build/
	-rm -f fakeps fakeps_*

