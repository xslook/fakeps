# Foolany
Foolany is a simple program to simulate some named processes.

While some companies use **Ciso Anyconnect** as VPN service, they may want you install some
softwares to make sure everything ***is safe***. But on your personal computer, it's annoying
and stains your room.


**WARN**: Use this is at your own risk.


### Usage
1. Download this program from release page or download it like below:

  ```sh
  go get github.com/xslook/foolany/cmd/foolany/
  ```

2. Run program to simulate target processes (for example, you need mse.exe and other.exe to pass Anyconnect's check)

  ```sh
  foolany -p mse.exe,other.exe -t 60
  ```
  It will run 60 seconds and startup two processes (mse.exe and other.exe) until program exit.


### Build
You can download source and build executable yourself.

First, clone it.
```sh
git clone https://github.com/xslook/foolany
```

then, build it with **make**:
```sh
make build
```


### TODO

- [ ] Support windows


### LICENSE
MIT LICENSE


