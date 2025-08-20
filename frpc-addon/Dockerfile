# 使用一个包含frp二进制文件的基础镜像
FROM ghcr.io/home-assistant/amd64-base:latest

# 安装jq，用于处理JSON
RUN apt-get update && apt-get install -y jq

# 下载并解压frpc
ARG FRPC_VERSION=0.51.3
ARG FRPC_ARCH=linux_amd64
ADD https://github.com/fatedier/frp/releases/download/v${FRPC_VERSION}/frp_${FRPC_VERSION}_${FRPC_ARCH}.tar.gz /tmp/frp.tar.gz
RUN tar -zxvf /tmp/frp.tar.gz -C /tmp/ \
    && mv /tmp/frp_${FRPC_VERSION}_${FRPC_ARCH}/frpc /usr/bin/frpc \
    && chmod +x /usr/bin/frpc \
    && rm -rf /tmp/frp.tar.gz /tmp/frp_${FRPC_VERSION}_${FRPC_ARCH}

# 复制脚本和配置文件
COPY run.sh /run.sh
RUN chmod +x /run.sh

# 运行启动脚本
CMD ["/run.sh"]
