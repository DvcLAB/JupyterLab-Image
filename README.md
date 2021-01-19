

# 使用文档

## 基本说明

DvcLAB的JupyterLab镜像基于开源的JupyterLab，提供在线的交互式开发调试工具。使用者无需关注安装配置，在DvcLAB平台直接可使用Notebook，编写和调测模型训练代码，拉取已有项目，挂载数据集，然后基于代码进行模型的训练。

- JupyterLab是一个交互式的开发环境，是Jupyter Notebook的下一代产品，可以使用它编写Notebook、操作终端、编辑MarkDown文本、打开交互模式等功能。关于JupyterLab的详细操作指导，请参见[JupyterLab官网文档](https://jupyterlab.readthedocs.io/en/stable/)。

此外，DvcLAB还提供了JupyterLab的docker镜像，您可以在本地安装docker后获取此镜像，从而可快速在本地进行深度学习的相关开发，让您工作学习更加高效。

### 支持的AI引擎

工作环境多种AI引擎，可以根据需要的引擎下载使用不同的镜像。目前只支持TF2.2,Pytorch1.6,未来更多版本的工作环境。

| 工作环境名称    | 预置的AI引擎及版本 | 适配芯片 |
| --------------- | ------------------ | -------- |
| TensorFlow2.2.0 | CPU/GPU            | CPU/GPU  |
| Pytorch1.6 | CPU/GPU            | CPU/GPU  |
### 镜像启动

拉取镜像后，下载docker-compose文件和环境变量文件，之后可通过一句话启动JupyterLab

```docker-compose -f /opt/docker-compose-jupyterlab.yaml --env-file=/opt/variable.env up```

## JupyterLab简介及常用操作

JupyterLab是一个交互式的开发环境，是Jupyter Notebook的下一代产品，可以使用它编写Notebook、操作终端、编辑MarkDown文本、打开交互模式、查看csv文件及图片等功能。

可以说，JupyterLab是开发者们下一阶段更主流的开发环境。JupyterLab支持更加灵活和更加强大的项目操作方式，但具有和Jupyter Notebooks一样的组件。

### 打开JupyterLab

1. 登录ModelArts管理控制台，在左侧菜单栏中选择**“开发环境 > Notebook”**，进入Notebook管理列表。
2. 选择状态为**“运行中”**的Notebook实例，单击操作列的“打开”访问Notebook。
3. 进入JupyterLab页面后，自动打开Launcher页面，如下图所示。您可以使用开源支持的所有功能，详细操作指导可参见JupyterLab官网文档。
   ![点击放大](C:\Users\22952\AppData\Roaming\Typora\typora-user-images\image-20210118194239087.png)

### 新建并打开Notebook

进入JupyterLab主页后，可在“Notebook”区域下，选择适用的AI引擎，单击后将新建一个对应框架的Notebook文件。

由于每个Notebook实例选择的工作环境不同，其支持的AI框架也不同，下图仅为示例，请根据实际显示界面选择AI框架，ModelArts支持的所有框架版本及Python版本请参见[支持的AI引擎](https://support.huaweicloud.com/engineers-modelarts/modelarts_23_0033.html#modelarts_23_0033__section191109611479)。

![点击放大](C:\Users\22952\AppData\Roaming\Typora\typora-user-images\image-20210118194308883.png)

新建的Notebook文件将呈现在左侧菜单栏中。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266084894.png)

### 新建文件并打开Console

Console的本质为Python终端，输入一条语句就会给出相应的输出，类似于Python原生的IDE。

进入JupyterLab主页后，可在“Console”区域下，选择适用的AI引擎，单击后将新建一个对应框架的Notebook文件。

由于每个Notebook实例选择的工作环境不同，其支持的AI框架也不同，下图仅为示例，请根据实际显示界面选择AI框架。

![点击放大](C:\Users\22952\AppData\Roaming\Typora\typora-user-images\image-20210118194440103.png)

文件创建成功后，将直接呈现Console页面。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266135340.png)

### 上传文件

进入JupyterLab页面后，您可以单击左上角“Upload File”快捷键，从本地选择一个文件上传。

此功能上传的文件大小有一定限制，如果您的文件大小超过限制，建议使用其他方式上传，详细请参见[数据上传至JupyterLab](https://support.huaweicloud.com/engineers-modelarts/modelarts_23_0332.html)。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266137396.png)

### 编辑文件

JupyterLab可以在同一个窗口同时打开几个Notebook或文件（如HTML、TXT、Markdown等），以页签形式展示。

JupyterLab的一大优点是，可以任意排版多个文件。在右侧文件展示区，您可以拖动打开文件，随意调整文件展示位置，可以同时打开多个文件。
![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266136066.png)

当在一个Notebook中写代码时，如果需要实时同步编辑文件并查看执行结果，可以新建该文件的多个视图。

打开此文件，然后单击菜单栏**“File>New View for Notebook”**，即可打开多个视图。
![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266136837.png)

### JupyterLab常用快捷键和插件栏

![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266170955.png)

| 快捷键                                                       | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266170999.png) | 打开Launcher页面，可快速创建新的Notebook、Console或其他文件。 |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266171113.png) | 创建文件夹。                                                 |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266171115.png) | 上传文件。详细说明可参见[上传文件](https://support.huaweicloud.com/engineers-modelarts/modelarts_23_0209.html#modelarts_23_0209__section172463910383) |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266171118.png) | 更新文件夹。                                                 |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266171214.png) | Git插件，可连接此Notebook实例关联的Github代码库。详细使用指导可参见[使用Git插件](https://support.huaweicloud.com/engineers-modelarts/modelarts_23_0281.html)。 |

| 插件                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266171225.png) | 文件列表。单击此处，将展示此Notebook实例下的所有文件列表。   |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266172724.png) | 当前实例中正在运行的Terminal和Kernel。                       |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266172740.png) | Git插件，可以方便快捷的使用Github代码库。详细指导请参见[使用Git插件](https://support.huaweicloud.com/engineers-modelarts/modelarts_23_0281.html)。 |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266172941.png) | 快速启动命令。                                               |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266173712.png) | 查看正在打开的文件页签。                                     |
| ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0266174053.png) | 文档结构图。                                                 |



## 使用Git插件

针对带Github代码库的Notebook实例，可以在JupyterLab页面中使用Git插件快速查看内容，并提交修改后的代码。

### 前提条件

已创建带Git存储库的Notebook，且Notebook处于运行中状态。

### 打开JupyterLab的git插件

1. 在Notebook列表中，选择一个带Git存储库的实例，单击名称打开Notebook实例。

2. 进入

   “Jupyter”

   页面后，单击右上角的

   “Open JupyterLab”

   进入

   “JupyterLab”

   页面。

   下图所示图标，为JupyterLab的git插件。

   ![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0258313451.png)

### 查看代码库信息

在Name下方列表中，选中您希望使用的文件夹，双击打开，然后单击左侧git插件图标进入此文件夹对应的代码库。

![img](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0258315503.png)

即可看到当前代码库的信息，如仓库名称、分支、历史提交记录等。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0258315678.png)



### 查看修改的内容

如果修改代码库中的某个文件，在“Changes”页签的**“Changed”**下可以看到修改的文件，并点击修改文件名称右侧的“Diff this file”，可以看到修改的内容。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0257873826.jpg)

### 提交修改的内容

确认修改无误后，单击修改文件名称右侧的“Stage this change”，文件将进入**“Staged”**状态，相当于执行了**git add**命令。在左下方输入本次提交的Message，单击“Commit”，相当于执行了**git commit**命令。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0257873827.jpg)

此时，可以在“History”页签下看到本地提交已成功。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0257873828.jpg)

单击“push”按钮，相当于执行**git push**命令，即可提交代码到GitHub仓库中。提交成功后会提示“Git Push completed successfully”。若OAuth鉴权的token过期，则此时再push会弹框让输入用户的token或者账户信息，按照提示输入即可。

![点击放大](https://support.huaweicloud.com/engineers-modelarts/zh-cn_image_0257873829.jpg)

完成上述操作后，可以在JupyterLab的git插件页面的History页签，看到**“origin/HEAD”**和**“orgin/master”**已指向最新一次的提交。同时在GitHub对应仓库的commit记录中也可以查找到对应的信息。
