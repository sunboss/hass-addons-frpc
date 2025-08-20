#!/usr/bin/with-contenv bashio

# 从 HA 加载选项
SERVER_ADDR=$(bashio::config 'server_addr')
SERVER_PORT=$(bashio::config 'server_port')
TOKEN=$(bashio::config 'token')
USER=$(bashio::config 'user')
PORTS=$(bashio::config 'ports' | jq -c '.[]')

# 生成 frpc.ini
cp /frpc.ini.template /config/frpc.ini
echo "[common]" >> /config/frpc.ini
echo "server_addr = $SERVER_ADDR" >> /config/frpc.ini
echo "server_port = $SERVER_PORT" >> /config/frpc.ini
if [ -n "$TOKEN" ]; then
    echo "token = $TOKEN" >> /config/frpc.ini
fi
if [ -n "$USER" ]; then
    echo "user = $USER" >> /config/frpc.ini
fi

# 添加每个端口配置
while IFS= read -r port; do
    NAME=$(echo "$port" | jq -r '.name')
    TYPE=$(echo "$port" | jq -r '.type')
    LOCAL_IP=$(echo "$port" | jq -r '.local_ip')
    LOCAL_PORT=$(echo "$port" | jq -r '.local_port')
    REMOTE_PORT=$(echo "$port" | jq -r '.remote_port')
    
    echo "[$NAME]" >> /config/frpc.ini
    echo "type = $TYPE" >> /config/frpc.ini
    echo "local_ip = $LOCAL_IP" >> /config/frpc.ini
    echo "local_port = $LOCAL_PORT" >> /config/frpc.ini
    echo "remote_port = $REMOTE_PORT" >> /config/frpc.ini
done <<< "$PORTS"

# 运行 FRPC
frpc -c /config/frpc.ini
