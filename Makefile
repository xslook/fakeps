
.PHONY: build
build:
	go build cmd/foolany/foolany.go


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32:
	GOOS=windows GOARCH=amd64 go build -o foolany_32.exe cmd/foolany/foolany.go

.PHONY: build-win64
build-win64:
	GOOS=windows GOARCH=amd64 go build -o foolany_64.exe cmd/foolany/foolany.go

.PHONY: build-mac
build-mac:
	GOOS=darwin GOARCH=amd64 go build -o foolany_mac cmd/foolany/foolany.go

.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build -o foolany_linux cmd/foolany/foolany.go


.PHONY: worker
worker:
	-mkdir -p build
	GOOS=linux GOARCH=amd64 go build -o build/worker_linux cmd/worker/worker.go
	GOOS=darwin GOARCH=amd64 go build -o build/foolany_mac cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/foolany_64.exe cmd/worker/worker.go
	GOOS=windows GOARCH=amd64 go build -o build/foolany_32.exe cmd/worker/worker.go


.PHONY: clean
clean:
	-rm -rf build/
	-rm -f foolany foolany_*

