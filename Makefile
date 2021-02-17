
.PHONY: build
build:
	go build cmd/fakeps/fakeps.go


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32:
	GOOS=windows GOARCH=386 go build -o fakeps_win32.exe cmd/fakeps/fakeps.go

.PHONY: build-win64
build-win64:
	GOOS=windows GOARCH=amd64 go build -o fakeps_win64.exe cmd/fakeps/fakeps.go

.PHONY: build-mac
build-mac:
	GOOS=darwin GOARCH=amd64 go build -o fakeps_darwin cmd/fakeps/fakeps.go

.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build -o fakeps_linux cmd/fakeps/fakeps.go


.PHONY: clean
clean:
	-rm -f fakeps fakeps_*

