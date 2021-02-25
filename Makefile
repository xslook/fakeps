
.PHONY: build
build:
	go build


.PHONY: build-all
build-all: build-win build-mac build-linux


.PHONY: build-win
build-win: build-win64 build-win32

.PHONY: build-win32
build-win32:
	GOOS=windows GOARCH=386 go build -o fakeps_win32.exe

.PHONY: build-win64
build-win64:
	GOOS=windows GOARCH=amd64 go build -o fakeps_win64.exe

.PHONY: build-mac
build-mac:
	GOOS=darwin GOARCH=amd64 go build -o fakeps_darwin

.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build -o fakeps_linux


.PHONY: clean
clean:
	-rm -f fakeps fakeps_*

