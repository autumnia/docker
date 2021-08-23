
# 서버 설치

### 	리눅스 버전 및 종류 확인

```
	cat /etc/*-release | uniq
	=> Oracle Linux Server release 7.8
```

### oracle linux 설치
```
    cd /etc/yum.repos.d/
	wget http://yum.oracle.com/public-yum-ol7.repo
	
	vi public-yum-ol7.repo
		[ol7_latest]  enabled=1
		[ol7_latest]  enabled=1
		[ol7_addons]  enabled=1

    yum install docker-engine

	systemctl start docker
	systemctl status docker
	
	selinux가 enable되어 있으면 컨테이너 가동 시 특정 디렉토리 접근에 문제가 있을 수 있다.
	/etc/sysconfig/selinux 의 설정에서 SELINUX=disabled로 하고 리붓을 한다.
	
    설치후 확인
	docker -v
		예) Docker version 19.03.1, build 74b1e89    
```

### Centos7 설치
```
    yum install -y yum-utils
    yum-config-mnager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install -y docker-ce
    systemctl start docker
    docker --version

```


### ubuntu 20.04 설치
```
    sudo를 사용하고 싶지 않은 경우 
        sudo usermod -aG docker ${USER}
        sudo su - ${USER}  <= 암호입력 필요
        id -nG  <== 확인용

    sudo apt update & apt upgrade
    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common    

    GPG Key 인증
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    아키텍처 확인    
    arch x86_64

    레포지토리 등록
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"   

    도커설치
    sudo apt-get update 
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    확인
    docker -v

    자동 기동
    sudo systemctl enable docker && service docker start
    service docker status



```


### windows or Mac 설치
```
    https://www.docker.com/get-started
```

