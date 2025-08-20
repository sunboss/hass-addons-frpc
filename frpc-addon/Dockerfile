# 使用 Home Assistant 的基础镜像，支持多架构
ARG BUILD_FROM
FROM $BUILD_FROM

# 安装依赖
RUN apk add --no-cache wget tar jq

# 根据架构下载对应的 FRPC 二进制文件
ARG BUILD_ARCH
RUN case "${BUILD_ARCH}" in \
        aarch64) FRP_ARCH="arm64" ;; \
        amd64) FRP_ARCH="amd64" ;; \
        armhf) FRP_ARCH="arm" ;; \
        armv7) FRP_ARCH="arm" ;; \
        i386) FRP_ARCH="386" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}"; exit 1 ;; \
    esac \
    && wget https://github.com/fatedier/frp/releases/download/v0.60.0/frp_0.60.0_linux_${FRP_ARCH}.tar.gz \
    && tar -xzf frp_0.60.0_linux_${FRP_ARCH}.tar.gz \
    && mv frp_0.60.0_linux_${FRP_ARCH}/frpc /usr/bin/frpc \
    && chmod +x /usr/bin/frpc \
    && rm -rf frp_0.60.0_linux_${FRP_ARCH}*

# 复制启动脚本和模板
COPY run.sh /run.sh
COPY frpc.ini.template /frpc.ini.template
RUN chmod a+x /run.sh

CMD ["/run.sh"]
