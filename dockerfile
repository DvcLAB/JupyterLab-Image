ARG UBUNTU_VERSION=18.04

ARG ARCH=
ARG CUDA=10.1
FROM nvidia/cuda${ARCH:+-$ARCH}:${CUDA}-base-ubuntu${UBUNTU_VERSION} as base
# ARCH and CUDA are specified again because the FROM directive resets ARGs
# (but their default value is retained if set previously)
ARG ARCH
ARG CUDA
ARG CUDNN=7.6.4.38-1
ARG CUDNN_MAJOR_VERSION=7
ARG LIB_DIR_PREFIX=x86_64
ARG LIBNVINFER=6.0.1-1
ARG LIBNVINFER_MAJOR_VERSION=6

# Needed for string substitution
SHELL ["/bin/bash", "-c"]

## A 更新源
#更新国内源
RUN touch /etc/apt/sources.list && echo "" > /etc/apt/sources.list
RUN echo -e "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse\n \
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse\n \
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse\n \
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse\n" >> /etc/apt/sources.list
RUN apt update

## B 安装cuda
# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-command-line-tools-${CUDA/./-} \
        # There appears to be a regression in libcublas10=10.2.2.89-1 which
        # prevents cublas from initializing in TF. See
        # https://github.com/tensorflow/tensorflow/issues/9489#issuecomment-562394257
        libcublas10=10.2.1.243-1 \ 
        cuda-nvrtc-${CUDA/./-} \
        cuda-cufft-${CUDA/./-} \
        cuda-curand-${CUDA/./-} \
        cuda-cusolver-${CUDA/./-} \
        cuda-cusparse-${CUDA/./-} \
        curl \
        libcudnn7=${CUDNN}+cuda${CUDA} \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip

# Install TensorRT if not building for PowerPC
RUN [[ "${ARCH}" = "ppc64le" ]] || { apt-get update && \
        apt-get install -y --no-install-recommends libnvinfer${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        libnvinfer-plugin${LIBNVINFER_MAJOR_VERSION}=${LIBNVINFER}+cuda${CUDA} \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*; }

# For CUDA profiling, TensorFlow requires CUPTI.
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Link the libcuda stub to the location where tensorflow is searching for it and reconfigure
# dynamic linker run-time bindings
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools
	

# Some TF tools expect a "python" binary
RUN ln -s $(which python3) /usr/local/bin/python
RUN python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Options:
#   tensorflow
#   tensorflow-gpu
#   tf-nightly
#   tf-nightly-gpu
# Set --build-arg TF_PACKAGE_VERSION=1.11.0rc0 to install a specific version.
# Installs the latest version by default.
ARG TF_PACKAGE=tensorflow-gpu
ARG TF_PACKAGE_VERSION=2.2.0
RUN python3 -m pip install --no-cache-dir ${TF_PACKAGE}${TF_PACKAGE_VERSION:+==${TF_PACKAGE_VERSION}}

# COPY bashrc /etc/bash.bashrc
# RUN chmod a+rwx /etc/bash.bashrc

RUN apt-get install -y vim wget git xz-utils s3fs yarn 
RUN cd /opt  && wget https://npm.taobao.org/mirrors/node/v12.4.0/node-v12.4.0-linux-x64.tar.xz    && tar -xvf node-v12.4.0-linux-x64.tar.xz  && cd node-v12.4.0-linux-x64/bin  &&  ./node -v   && ln -s /opt/node-v12.4.0-linux-x64/bin/node /usr/local/bin/node   && ln -s /opt/node-v12.4.0-linux-x64/bin/npm /usr/local/bin/npm \
 &&cd /opt &&rm -f *.xz
#RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

RUN python3 -m pip install --no-cache-dir jupyterlab==2.2.9 pipreqsnb pipreqs nbresuse==0.3.3 jupyterlab-git

RUN apt-get install -y openjdk-8-jdk

RUN cd /opt && wget http://mirror.bit.edu.cn/apache/kafka/2.3.1/kafka_2.11-2.3.1.tgz && tar -zxvf kafka_2.11-2.3.1.tgz && mv kafka_2.11-2.3.1 kafka \
&& export KAFKA_HOME=/opt/kafka && export PATH=$PATH:$KAFKA_HOME/bin &&rm -f *.tgz

COPY backend_extension /opt/backend_extension
RUN cd /opt/backend_extension && pip install . && jupyter lab --generate-config
COPY init_container.sh /opt/init_container 
COPY kafkamsg.sh /opt/kafkamsg.sh

RUN jupyter labextension install @vandalt/jupyterlab_dracula \
&& jupyter labextension install jupyterlab-drawio \
&& jupyter labextension install jupyterlab-system-monitor \
&& jupyter labextension install @jupyterlab/toc

RUN mkdir /workspace
WORKDIR /workspace

EXPOSE 22
EXPOSE 8988

CMD ["bash"]