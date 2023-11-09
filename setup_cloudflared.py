
import subprocess
import threading
import time
import socket
# import urllib.request
import argparse

# 创建参数解析器
parser = argparse.ArgumentParser()
# 添加名为"port"的参数
parser.add_argument("--port", help="Specify a port")

# 解析命令行参数
args = parser.parse_args()

# 访问参数值
port = args.port

# 打印参数值
# print("port:", port)

def install_cloudflared():
    # 检查 cloudflared 软件包是否已安装
    status = subprocess.run(['dpkg-query', '-W', 'cloudflared'], capture_output=True, text=True)
    is_installed = status.returncode == 0

    if not is_installed:
        # 下载 cloudflared 软件包
        subprocess.run(['wget', 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb'])

        # 安装 cloudflared 软件包
        subprocess.run(['dpkg', '-i', 'cloudflared-linux-amd64.deb'])
        
        # 检查安装是否成功
        status = subprocess.run(['dpkg-query', '-W', 'cloudflared'], capture_output=True, text=True)
        if status.returncode != 0:
            raise RuntimeError("安装 cloudflared 软件包失败。")
    else:
        print("cloudflared 已经安装。")



def iframe_thread(port):
  while True:
      time.sleep(0.5)
      sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      result = sock.connect_ex(('127.0.0.1', port))
      if result == 0:
        break
      sock.close()
  print("\nComfyUI finished loading, trying to launch cloudflared (if it gets stuck here cloudflared is having issues)\n")

  p = subprocess.Popen(["cloudflared", "tunnel", "--url", "http://127.0.0.1:{}".format(port)], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
  for line in p.stderr:
    l = line.decode()
    if "trycloudflare.com " in l:
      print("This is the URL to access ComfyUI:", l[l.find("http"):], end='')
    #print(l, end='')


# 调用 install_cloudflared() 方法安装 cloudflared
install_cloudflared()

threading.Thread(target=iframe_thread, daemon=True, args=(port,)).start()