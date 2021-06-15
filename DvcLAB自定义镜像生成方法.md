# DvcLAB自定义镜像

## 基础镜像服务构成

1. s3fs数据集挂载服务
2. keycloak用户认证
3. git项目管理
4. frp端口映射
5. kafka消息服务
6. JupyterLab及其插件
7. AI框架

## 自定义镜像构建

1. 首先通过如下命令进行docker仓库的认证，使用Keycloak的用户名、密码登录

   `docker login registry.dvclab.com`

2. 通过如下命令拉取DvcLAB仓库中的基础AI镜像

   `docker pull ${image}`

3. 基于DvcLAB提供的基础AI镜像，通过如下命令启动一个容器

   `docker run -it --name ${container_name} ${image} /bin/bash`

4. 通过如下命令进入容器环境，并进行自定义服务的安装、修改

   `docker exec -it ${container_name} /bin/bash`

5. 镜像修改完毕后，按`Ctrl+P+Q`退出容器环境

6. 通过如下命令将修改后的容器打包成新的镜像

   `docker commit ${container_name} registry.dvclab.com/${new_imag_ename}:${version}`

   **注意：**

   ​	a. 生成的新镜像的名称要是   registry.dvclab.com/***   格式的

7. 通过如下命令将打包后的新镜像上传到DvcLAB的docker仓库

   `docker push registry.dvclab.com/${new_imag_ename}:${version}`