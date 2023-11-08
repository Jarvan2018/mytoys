#!/bin/bash


# define define define


## colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # default color

COMFYUI_DIR=/workspace/ComfyUI

models_dir=${COMFYUI_DIR}/models
checkpoints_dir=${models_dir}/checkpoints
vae_dir=${models_dir}/vae
loras_dir=${models_dir}/loras
upscale_dir=${models_dir}/upscale_models
controlnet_dir=${models_dir}/controlnet
embeddings_dir=${models_dir}/embeddings




# install jq
if ! command -v jq &> /dev/null; then
    echo "jq 未找到，开始安装..."

    # 使用适当的包管理器安装 jq
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y jq
    elif command -v yum &> /dev/null; then
        sudo yum install -y jq
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y jq
    else
        echo "无法自动安装 jq，请手动安装。"
        exit 1
    fi

    echo "jq 安装成功！"
fi


function download() {
    url="$1"
    dir="$2"
    filename="$3"

    if [ -z "$filename" ]; then
        # 如果没有传递文件名参数，则使用默认逻辑
        if command -v wget &>/dev/null; then
            echo -e "${GREEN} 下载 自动命名 url: $url dir: $dir ${NC}"
            wget -P "$dir" "$url"
        else
            echo "wget is not installed. Please install wget manually."
            exit 1
        fi
    else
        # 如果传递了文件名参数，则使用给定的文件名
        if command -v wget &>/dev/null; then
            echo -e "${GREEN} 下载 手动命名 url: $url dir: $dir filename: $filename ${NC}"
            wget -P "$dir" -O "$dir/$filename" "$url"
        else
            echo "wget is not installed. Please install wget manually."
            exit 1
        fi
    fi
}

# aria2c 不能正确的识别 response Header.Content-Disposition
function download_aria2c() {
    url="$1"
    dir="$2"

    if command -v aria2c &>/dev/null; then
        aria2c --console-log-level=error -c -x 16 -s 16 -k 1M --dir="$dir" "$url"
    else
        echo "aria2c is not installed. Installing aria2c..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # 在Linux上安装aria2c
            sudo apt-get -y install -qq aria2
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            # 在macOS上安装aria2c
            brew install aria2
        else
            echo "Error: Unsupported operating system. Please install aria2c manually."
            exit 1
        fi

        # 安装aria2c后重新尝试下载
        aria2c --console-log-level=error -c -x 16 -s 16 -k 1M --dir="$dir" "$url"
    fi
}

getCivitaiModelVersionInfo() {
    url="https://civitai.com/api/v1/model-versions/$1"
    response=$(curl --location --request GET "$url" \
        --header 'Content-Type: application/json')

    # 检查curl命令是否成功执行
    if [ $? -eq 0 ]; then
        # 解析JSON数据
        type=$(echo "$response" | jq -r '.model.type')
        downloadUrl=$(echo "$response" | jq -r '.files[0].downloadUrl')
        filename=$(echo "$response" | jq -r '.files[0].name')

        echo "getCivitaiModelVersionInfo 数据, downloadUrl= $downloadUrl type= $type filename= $filename"

        save_url_to_dir "$downloadUrl" "$type" "$filename"

    else
        echo "HTTP request failed"
    fi
}



getCivitaiModelsInfo() {

    url="https://civitai.com/api/v1/models/$1"
    response=$(curl --location --request GET "$url" \
        --header 'Content-Type: application/json')

    # 检查curl命令是否成功执行
    if [ $? -eq 0 ]; then
        # 解析JSON数据
        type=$(echo "$response" | jq -r '.type')
        downloadUrl=$(echo "$response" | jq -r '.modelVersions[0].files[0].downloadUrl')
        filename=$(echo "$response" | jq -r '.modelVersions[0].files[0].name')

        echo "解析getCivitaiModelsInfo 数据, downloadUrl= $downloadUrl type= $type filename= $filename"

        save_url_to_dir "$downloadUrl" "$type" "$filename"

    else
        echo "HTTP request failed"
    fi
}

function save_url_to_dir() {
    url="$1"
    type="$2"
    filename="$3"

    if [ "$type" = "Checkpoint" ]; then
        dir="$checkpoints_dir"  # 注意变量赋值时使用双引号
    elif [ "$type" = "TextualInversion" ]; then
        dir="$embeddings_dir"  # 注意变量赋值时使用双引号
    # elif [ "$type" = "Hypernetwork" ]; then
    #     dir="/path/to/hypernetwork"
    # elif [ "$type" = "AestheticGradient" ]; then
    #     dir="/path/to/aesthetic_gradient"
    elif [ "$type" = "LORA" ]; then
        dir="$loras_dir"  # 注意变量赋值时使用双引号
    elif [ "$type" = "Controlnet" ]; then
        dir="$controlnet_dir"  # 注意变量赋值时使用双引号
    # elif [ "$type" = "Poses" ]; then
    #     dir="/path/to/poses"
    else
        echo "Unknown type"
        return 1
    fi

    # 创建目录（如果不存在）
    mkdir -p "$dir"

    # 下载文件并保存到指定目录
    download "$url" "$dir" "$filename"
}


function parseCivitaiUrl() {
    url="$1"
    model_id=$(echo "$url" | awk -F'[/?]' '{print $5}')
    # 提取查询参数的值
    param_name="modelVersionId"
    model_version_id=$(echo "$url" | awk -F'[?&]' '{for (i=2; i<=NF; i++) {split($i,a,"="); if (a[1]=="'"$param_name"'") print a[2]}}' | sed 's/%20/ /g')
    # model_version_id=$(echo "$url" | awk -F'[/?]' '{print $7}')

    if [ -n "$model_version_id" ]; then
        echo "url: $url modelVersionId parameter exists"
        getCivitaiModelVersionInfo "$model_version_id"
    else
        echo "url: $url  modelVersionId parameter does not exist"
        getCivitaiModelsInfo "$model_id"
    fi
}

function handleCode() {
    code="$1"
    if [[ $code == *" "* ]]; then
        url=$(echo "$code" | cut -d ' ' -f 1)
        dir=$(echo "$code" | cut -d ' ' -f 2)
        echo "正在下载 $url 到 $dir ..."
        download $url $dir
    else
        url="$code"
        echo "正在Civitai 下载 $url ..."
        parseCivitaiUrl "$url"
    fi

    echo "下载 $code 完成！"
}



## unit test cases

# civitai_res_array=()


# # Download from Civital
# ## Checkpoint model
# ### majicMIX realistic
# civitai_res_array+=("https://civitai.com/models/43331")
# civitai_res_array+=("https://civitai.com/models/43331?modelVersionId=79068")


# ## embeddings

# ### easynegative.safetensors
# civitai_res_array+=("https://civitai.com/models/7808/easynegative")
# civitai_res_array+=("https://civitai.com/models/7808?modelVersionId=9536")


# ### badhandv4.pt
# civitai_res_array+=("https://civitai.com/models/16993/badhandv4-animeillustdiffusion")



# # Download from  Huggingface
# ## upscale
# civitai_res_array+=("https://huggingface.co/embed/upscale/resolve/main/4x-UltraSharp.pth $upscale_dir")
# civitai_res_array+=("https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth $upscale_dir")


# ## VAE
# civitai_res_array+=("https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors $vae_dir")

# ## controlnet model
# ### openpose
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth $controlnet_dir")
# ### tile
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth $controlnet_dir")
# ### qrcode_monster
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/v2/control_v1p_sd15_qrcode_monster_v2.yaml $controlnet_dir")
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/v2/control_v1p_sd15_qrcode_monster_v2.safetensors $controlnet_dir")


# # AnimateDiff Model
# animateDiff_model_dir=/workspace/ComfyUI/custom_nodes/ComfyUI-AnimateDiff/models
# civitai_res_array+=("https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt $animateDiff_model_dir")



# for element in "${civitai_res_array[@]}"; do
#     handleCode "$element"
# done



# echo -e "\n${GREEN}Done!${NC}"

# fi