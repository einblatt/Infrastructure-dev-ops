#!/usr/bin/env bash
# =============================================================================
# docker + docker-compose 安装脚本
# 已测试环境: Ubuntu-22.04 LTS
# =============================================================================

set -euo pipefail
IFS=$'\n\t'

die() {
    local exit_code=$?
    local cmd="$1"
    local line_no="${BASH_LINENO[1]}"
    echo "=========================================================================" >&2
    echo "ERROR: 第 ${line_no} 行命令执行失败！" >&2
    echo "命令: $cmd" >&2
    echo "退出码: $exit_code" >&2
    echo "=========================================================================" >&2
    exit "$exit_code"
}

run() {
    local cmd="$*"
    echo "RUNNING: $cmd"
    if ! eval "$cmd" 2> >(tee ./cmd_error.log >&2); then
        echo "CAPTURED STDERR:" >&2
        cat ./cmd_error.log >&2
        die "$cmd"
    fi
    rm -f ./cmd_error.log
}

# -------------------------- 开始安装 ----------------------------------

echo "开始安装 Docker 及 docker-compose..."

# 1. 更新包索引
run "sudo apt-get update"

# 2. 安装依赖
run "sudo apt-get install -y ca-certificates curl"

# 3. 创建 keyrings 目录
run "sudo install -m 0755 -d /etc/apt/keyrings"

# 4. 下载 Docker GPG 公钥
run "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"

# 5. 设置公钥权限
run "sudo chmod a+r /etc/apt/keyrings/docker.asc"

# 6.将仓库添加到APT源
run $'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $( . /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'

# 7. 再次更新包索引（包含新源）
run "sudo apt-get update"

# 8. 安装 Docker 核心组件
run "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"

# 9. 启用并启动 Docker 服务
run "sudo systemctl enable docker"
run "sudo systemctl start docker"

# 10. 安装独立版 docker-compose（可选，插件已装，此为备用）
COMPOSE_VERSION="v2.24.6"
run "sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose"
run "sudo chmod +x /usr/local/bin/docker-compose"

# 11. 验证安装
run "docker --version"
run "docker compose version"  # 使用新插件方式

echo "========================================================================="
echo "所有步骤执行成功！"
echo "docker 安装完成!"
echo "docker-compose安装完成!"
echo "========================================================================="
exit 0
