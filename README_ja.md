HSRについて
-------------------

Human Support Robot (HSR）についての情報入手および論文等に利用される場合には、以下をご参照ください。

https://robomechjournal.springeropen.com/articles/10.1186/s40648-019-0132-3

dockerのインストール
-------------------

シミュレータの実行にはdockerとdocker-composeが必要です。

WindowsとMacの場合、docker for window/macをインストールしてください。

Linuxの場合、以下のコマンドを入力してdockerをインストールしてください。

```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
```

以下のコマンドを入力して、一般ユーザでもdockerコマンドを実行可能にします。

```sh
$ sudo usermod -aG docker <ユーザ名>
```

コマンドを入力できたら、一度ログアウトしてログインしなおしてください。

以下のコマンドを入力して、dockerが正常に実行できることを確認します。

```sh
$ docker info
```

以下のコマンドを入力して、docker-composeをインストールします。
apt-getでインストールできるdocker-composeは古いので、以下の各コマンドを入力して最新のdocker-composeをインストールしてください。

```sh
$ sudo apt-get remove docker-compose
$ COMPOSE_VERSION=$(wget https://api.github.com/repos/docker/compose/releases/latest -O - | grep 'tag_name' | cut -d\" -f4)
$ sudo wget https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
$ sudo chmod 755 /usr/local/bin/docker-compose
```

使い方
-----

以下のコマンドを入力して、このレポジトリをクローンしてください。

```sh
$ git clone --recursive https://github.com/hsr-project/tmc_wrs_docker.git
$ cd tmc_wrs_docker
```

シミュレータの実行に必要な各イメージをダウンロードします。
大量のデータをダウンロードするので、高速なネットワーク回線に接続した環境で実行してください。

```sh
$ ./pull-images.sh
```

シミュレータの起動
---------------

以下のコマンドを入力してシミュレータを起動してください。

```sh
$ docker-compose up
```

以下の各URLをブラウザで開いて開発を進めてください。

- シミュレータ画面　http://localhost:3000
- IDE http://localhost:3001
- jupyter notebook http://localhost:3002

GPU環境でのシミュレータの起動
-------------------------

nvidiaのビデオカードがある場合は、レンダリングをGPU上で行うことでシミュレーションを高速化することができます。

まずは、以下のURLを参考にnvidia-dockerをインストールしてください。
https://github.com/NVIDIA/nvidia-docker

レンダリングはサーバ上で立ち上がったディスプレイ番号0のXサーバ上で行います。
以下のコマンドを入力してdocker内部からXサーバへのアクセスを許可してください。
```sh
$ DISPLAY=:0 xhost si:localuser:root
```

以下のコマンドを入力してシミュレータを起動してください。

```sh
$ docker-compose -f docker-compose.nvidia.yml up
```

以下の各URLをブラウザで開いて開発を進めてください。

- シミュレータ画面　http://localhost:3000
- IDE http://localhost:3001
- jupyter notebook http://localhost:3002

自律移動の実行
---------------

シミュレータ画面上のgazeboで、再生ボタン(左下の右矢印)をクリックしてシミュレーションを開始し、
IDE上の画面下のターミナルにて、下記コマンドでrvizを起動してください。

```
rviz -d $(rospack find hsrb_rosnav_config)/launch/hsrb.rviz
```

rvizはシミュレータ画面上に表示されます。rviz上の「2D Nav Goal」をクリックし、自律移動のゴールをクリックすると目的の場所まで自律移動します。

dockerのhost PCでの操作
---------------

docker imageを立ち上げているhost PCからシミュレータ上のroscoreと通信するには、ROS_MASTER_URIを適切に設定する必要があります。本package直下にある下記スクリプトをsourceすることで、ROS_MASTER_URIの設定が可能です。
```sh
$ source ./set-rosmaster.sh
```
シミュレータを開始後、host PCにてROS通信ができることを確認してください。

Authors
---------------
 * Yosuke Matsusaka

Contact
---------------
 * HSR Support <xr-hsr-support@mail.toyota.co.jp>

LICENSE
---------------
This software is released under the BSD 3-Clause Clear License, see LICENSE.txt.
