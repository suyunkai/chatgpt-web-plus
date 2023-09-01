# 询问用户版本号
read -p "请输入版本号: " VERSION

# 显示版本号并获取用户确认
read -p "版本号是 ${VERSION}，是否确认？(y/n)" -n 1 -r
echo # 移到新行
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # 如果用户确认，给 Docker 容器打上版本号标签
    echo "-------------------- Build chatgpt-web-plus --------------------------"
    sudo docker build -t suyunkai46/chatgpt-web-plus:latest -t suyunkai46/chatgpt-web-plus:${VERSION} .

else
    echo "操作已取消."
fi

# 提示用户确认上传
read -p "是否确认上传 ${IMAGE_NAME}:${TAG} 到 Docker Hub？(y/n)" -n 1 -r
echo # 移到新行
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # 登录 Docker Hub
    sudo docker login

    # 推送镜像到 Docker Hub
    sudo docker push suyunkai46/chatgpt-web-plus:latest
    sudo docker push suyunkai46/chatgpt-web-plus:${VERSION}
else
    echo "操作已取消."
fi
