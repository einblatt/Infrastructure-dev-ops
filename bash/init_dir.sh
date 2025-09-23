#初始化默认目录
init_dir=/usr/local/docker
mkdir -p "$init_dir" "$init_dir/app"
if [ $? -eq 0 ]; then
    echo "初始化目录：$init_dir, $init_dir/app"
else
    echo "目录创建失败"
    exit 1
fi

cd ../dev-ops/docker
cp -r mysql nginx redis /usr/local/docker
cd ../../bash