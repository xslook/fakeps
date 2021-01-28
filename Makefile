
.PHONY: build
build: worker
	go build cmd/fakeps/fakeps.go


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32: worker
	GOOS=windows GOARCH=386 go build -o fakeps_win32.exe cmd/fakeps/fakeps.go

.PHONY: build-win64
build-win64: worker
	GOOS=windows GOARCH=amd64 go build -o fakeps_win64.exe cmd/fakeps/fakeps.go

.PHONY: build-mac
build-mac: worker
	GOOS=darwin GOARCH=amd64 go build -o fakeps_darwin cmd/fakeps/fakeps.go

.PHONY: build-linux
build-linux: worker
	GOOS=linux GOARCH=amd64 go build -o fakeps_linux cmd/fakeps/fakeps.go


.PHONY: worker
worker:
	-mkdir -p build
	GOOS=linux GOARCH=amd64 go build -o build/worker_linux64 cmd/worker/worker.go
	GOOS=linux GOARCH=386 go build -o build/worker_linux32 cmd/worker/worker.go
	GOOS=darwin GOARCH=amd64 go build -o build/worker_darwin cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/worker_win64 cmd/worker/worker.go
	GOOS=windows GOARCH=386 go build -o build/worker_win32 cmd/worker/worker.go


.PHONY: clean
clean:
	-rm -rf build/
	-rm -f fakeps fakeps_*

