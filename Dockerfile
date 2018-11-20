#An environment to run sgx applications

FROM ubuntu:14.04

MAINTAINER Amanda Souza <amandasouza@cpin.ufcg.edu.br>

ARG SGX_VERSION

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install --no-install-recommends -y software-properties-common && \
                    add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && \
                    apt-get install --no-install-recommends -y git build-essential ocaml automake python autoconf libtool \
                                         libcurl4-openssl-dev libprotobuf-dev libprotobuf-c0-dev protobuf-compiler curl make \
                                         unzip wget libssl-dev g++-4.9 g++-5 cmake nano && \
                                         rm -rf /var/lib/apt/lists/*

#Install SGX Drivers and PSW/SDK
WORKDIR /home/sgx/drivers
RUN wget https://github.com/01org/linux-sgx/archive/sgx_"$SGX_VERSION".tar.gz && \
    tar -xf sgx_"$SGX_VERSION".tar.gz && rm -rf sgx_"$SGX_VERSION".tar.gz
WORKDIR /home/sgx/drivers/linux-sgx-sgx_"$SGX_VERSION"/

RUN ./download_prebuilt.sh && \
    make && \
    make psw_install_pkg && \
    make sdk_install_pkg && \
    mkdir -p /opt/intel && \
    cd /opt/intel && \
    /home/sgx/drivers/linux-sgx-sgx_"$SGX_VERSION"/linux/installer/bin/sgx_linux_x64_psw_*.bin && \
    sh -c 'echo yes | /home/sgx/drivers/linux-sgx-sgx_"$SGX_VERSION"/linux/installer/bin/sgx_linux_x64_sdk_*.bin' && \
    /bin/bash -c 'source /opt/intel/sgxsdk/environment' && \
    rm -rf /home/sgx/drivers/*

RUN apt-get clean && \
    apt-get autoclean -y && \
    apt-get autoremove -y  && \
    rm -rf /bd_build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/ssh/ssh_host_* && \
    du -sh /var/cache/apt/archives

CMD ["/bin/bash"]
