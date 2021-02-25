# Fakeps
Fakeps is a simple program to simulate some named processes.


### Usage
1. Download this program from [release](https://github.com/xslook/fakeps/releases/latest) page and unzip it.
2. Run program to simulate target processes (for example, mse.exe and other.exe)

  ```sh
  fakeps -p mse.exe,other.exe -t 60
  ```
  It will run 60 seconds and startup two processes (mse.exe and other.exe) until program exit.


### Install from source
If you have **golang** installed, then just `go get` it.
```sh
go get github.com/xslook/fakeps
```


### LICENSE
MIT LICENSE


