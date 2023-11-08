#!/bin/bash
source shared.sh


echo -e "${GREEN}欢迎使用Vast.AI ComfyUI 下载脚本${NC}"
echo -e "${GREEN}Welcome to use Vast.AI ComfyUI download script${NC}"

# # 等待用户输入下载的URL
while true; do
    echo "请输入要下载的URL（Civitai链接将自动匹配对应的文件夹，Huggingface则需要URL后面跟 空格 再根 对应路径 ）: "
    read -r input

    handleCode "$input"
    # 询问用户是否继续
    echo "是否继续下载？(Y/N)"
    read choice

    # 如果用户输入N，则退出循环
    if [[ $choice == "N" ]]; then
        break
    fi
done

