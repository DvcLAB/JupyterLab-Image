

# 使用文档

## 基本说明

DvcLAB的JupyterLab镜像基于开源的JupyterLab，提供在线的交互式开发调试工具。使用者无需关注安装配置，在DvcLAB平台直接可使用Notebook，编写和调测模型训练代码，拉取已有项目，挂载数据集，然后基于代码进行模型的训练。

- JupyterLab是一个交互式的开发环境，是Jupyter Notebook的下一代产品，可以使用它编写Notebook、操作终端、编辑MarkDown文本、打开交互模式等功能。关于JupyterLab的详细操作指导，请参见[JupyterLab官网文档](https://jupyterlab.readthedocs.io/en/stable/)。

此外，DvcLAB还提供了JupyterLab的docker镜像，您可以在本地安装docker后获取此镜像，从而可快速在本地进行深度学习的相关开发，让您工作学习更加高效。
### 意义

1. 本镜像整合了Keycloak用户认证、S3数据集管理、Git项目管理、常用JupyterLab插件等多种服务。容器在启动时会根据传入的环境变量参数，自动拉取项目文件、通过S3挂载数据集、扫描项目文件并安装依赖的package、启动JupyterLab。用户只需一步即可将项目导入、关联数据集、完成开发环境的搭建配置，将精力集中在模型的编写、调试和训练上。

2. 镜像支持云端和本地两种部署方式，可充分利用云端和本地的计算资源。
   - 使用云端的JupyterLab镜像服务时，用户可以根据需要选择合适的计算资源，并一键部署在线开发环境，无缝衔接的项目托管、数据管理。启动服务之后访问容器运行的网址即可进行开发使用，且不限地域时间。
   - 本地部署时，用户在可安装docker服务后拉取相应镜像，并通过一行代码即可启动JupyterLab的相关服务。此外，用户还可以通过frp等服务将端口映射到公网，进而远程访问本地的JupyterLab服务、共享用户本地的算力，最大限度利用本地服务器的计算资源。

### 使用场景

此JupyterLab镜像有着丰富的使用场景，深度学习的初学者、兴趣开发者和在校生均可使用该镜像。
1. 对于深度学习的初学者，用户可以快速部署开发环境，加载提供的深度学习项目、使用预置的算法进行模型训练，从而进行学习和使用。
2. 对于有基础的用户，您可以选择自己编写模型算法，同时使用提供的数据集服务，快速挂载数据集。训练完成后可使用整合的Git服务将项目推送至远端进行保存。
3. 无论是何种使用环境，此镜像都能节省用户配置环境的时间、快速加载数据集，且用户可根据需要选择使用本地或云端的计算资源。

### 支持的AI引擎

工作环境多种AI引擎，可以根据需要的引擎下载使用不同的镜像。目前只支持TF2.2、Pytorch1.6，未来更多版本的工作环境。

| 工作环境名称    | 预置的AI引擎及版本 | 适配芯片 |
| --------------- | ------------------ | -------- |
| TensorFlow2.2.0 | CPU/GPU            | CPU/GPU  |
| Pytorch1.6 | CPU/GPU            | CPU/GPU  |

### 项目\数据集列表
| **项目名称**      | **对应bucket的名称** | **项目地址**                                  | **说明**                                   |
| ----------------- | -------------------- | --------------------------------------------- | ------------------------------------------ |
| CNN               | mnist                | https://github.com/DvcLAB/CNN                 | 使用CNN网络对mnist数据集的衣服进行分类     |
| covid19_detection | covid19              | https://github.com/linstein/covid19_detection | 使用CNN网络检测CT肺部图片判断是否为covid19 |
| container_test    | demo                 | https://github.com/DvcLAB/container_test      | 使用word2vector进行新闻分类                |

## JupyterLab容器运行方式

### docker/docker-compose安装

```shell
#docker安装
curl -sSL https://get.daocloud.io/docker | sh \
&& sudo systemctl enable docker \
&& sudo systemctl start docker

#docker-compose安装
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose
```

### nvidia运行环境安装（可选）

根据是否使用GPU进行tensorflow运算，选择安装。**若不安装，则需要去除**docker-compose-jupyterlab.yaml文件中`runtime: nvidia`这一行。

1. nvidia driver安装

   ```
   # 查看推荐驱动安装版本
   apt install ubuntu-drivers -q && ubuntu-drivers devices
   
   # 安装驱动
   apt install nvidia-driver-460
   
   # 验证驱动安装成功
   nvidia-smi
   ```

2. nvidia-container-runtime安装

   ```shell
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list \
   && apt-get update 
   
   apt-get install nvidia-container-runtime 
   
   cat > /etc/docker/daemon.json <<EOF
   {
       "runtimes": {
           "nvidia": {
               "path": "nvidia-container-runtime",
               "runtimeArgs": []
           }
       }
   }
   EOF
   
   sudo systemctl restart docker
   ```

### 拉取镜像

1. 添加dvclab仓库源

```
cat > /etc/docker/daemon.json<<EOF
{
  "registry-mirrors": ["https://jioksect.mirror.aliyuncs.com","https://registry.dvclab.com"],
  "insecure-registries":["https://registry.dvclab.com"]
}
EOF

systemctl restart docker
```

2. 拉取jupyterlab镜像

```
docker pull registry.dvclab.com/tf2.2:1.0
docker tag registry.dvclab.com/tf2.2:1.0  tf2.2:1.0
```

### 获取并修改配置文件

1. 下载环境变量文件[variable.env](https://drive.google.com/file/d/1ZXps-kJ1dCng8vHIzoPStOgHVs--HmG6/view?usp=sharing)和[docker-compose-jupyterlab.yaml](https://drive.google.com/file/d/1aN60j0bJQv01StbzHY6xUDLEB8hKw-dK/view?usp=sharing)文件。

2. 将这两个配置文件放到/opt文件夹下

3. 通过修改[variable.env](https://drive.google.com/file/d/1ZXps-kJ1dCng8vHIzoPStOgHVs--HmG6/view?usp=sharing)中，下面3个参数来选择加载的项目和它对应数据集

```
git_url=${}
branch=${}
project=${}
```

   下载的文件**默认将word2vector的项目作为示例**

### 运行容器

```
docker-compose -f /opt/docker-compose-jupyterlab.yaml --env-file=/opt/variable.env up
```
