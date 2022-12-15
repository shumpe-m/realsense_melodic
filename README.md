# realsense_melodic

## set up
- このリポジトリをクローン

- Clone this repository.
```
git clone https://github.com/shumpe-m/realsense_melodic.git
```
- realsenseを接続し、ホストマシンでデバイスを確認

- Connect realsense and check device on host machine.
```
$ sudo apt install v4l-utils 
$ v4l2-ctl --list-device
    Intel(R) RealSense(TM) Depth Ca (usb-0000:00:14.0-7):
	    /dev/video0
	    /dev/video1
	    /dev/video2
	    /dev/video3
	    /dev/video4
	    /dev/video5

```
- Docker/run.shの --deviceを書き換える。

- Rewrite --device in Docker/run.sh.


- 次のコードでDockerfileをビルドしてコンテナを起動する。

- The following code builds the Dockerfile and starts the container.
```
cd realsense_melodic/Docker
./build.sh
./run.sh
```

## realsense
- realsenseのビュワーを起動。

- Launch realsense viewer
```
realsense-viewer
```
<img src="https://raw.github.com/wiki/shumpe-m/realsense_melodic/images/viewer.png" width="500">
