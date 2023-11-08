#!/bin/bash
source shared.sh

# 使用python虚拟环境
# source /venv/bin/activate
source /workspace/myenv/bin/activate

# 可能需要安装 很多都依赖 
sudo apt-get update
sudo apt-get install -y libgl1-mesa-glx
pip install numba



echo -e "${GREEN}欢迎使用Vast.AI ComfyUI 预处理脚本${NC}"
echo -e "${GREEN}Welcome to use Vast.AI ComfyUI preprocessing script${NC}"

echo -e "${GREEN}===========================\n${NC}"
echo "将自动安装一些custom_nodes和他们的依赖"
echo "Will automatically install some custom_nodes and their dependencies"
echo -e "${GREEN}===========================\n${NC}"

# install Images Browser
# git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git
# cd sd-webui-infinite-image-browsing
# pip install -r requirements.txt
# # execute: python app.py --port=7888

# install custom_nodes
cd /workspace/ComfyUI/custom_nodes
# git clone https://github.com/LucianoCirino/efficiency-nodes-comfyui.git
git clone https://github.com/twri/sdxl_prompt_styler.git
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive
git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git
git clone https://github.com/SLAPaper/ComfyUI-Image-Selector.git
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
git clone https://github.com/Tropfchen/ComfyUI-Embedding_Picker.git
git clone https://github.com/AIGODLIKE/AIGODLIKE-COMFYUI-TRANSLATION.git
git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git
git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git ComfyUI-AnimateDiff
git clone https://github.com/SeargeDP/SeargeSDXL.git
git clone https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git
git clone https://github.com/BlenderNeko/ComfyUI_ADV_CLIP_emb.git

# 新增 制作Chengdu
git clone https://github.com/BadCafeCode/masquerade-nodes-comfyui
git clone https://github.com/laksjdjf/IPAdapter-ComfyUI

git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git
# --------需要安装依赖的节点 Start ------
# 老版本START
# # install custom_nodes with  requirements
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/WASasquatch/was-node-suite-comfyui/
cd /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui
pip install -r requirements.txt


cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
cd /workspace/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
# python install.py
git submodule update --init --recursive


cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger
cd /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger
pip install -r requirements.txt


cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/Fannovel16/comfyui_controlnet_aux/
cd comfyui_controlnet_aux
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/FizzleDorf/ComfyUI_FizzNodes.git
cd ComfyUI_FizzNodes
pip install -r requirements.txt


cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
cd ComfyUI-VideoHelperSuite
pip install -r requirements.txt



# cd /workspace/ComfyUI/custom_nodes
python -m pip install opencv-python

# 老版本END


# 新版本
# git clone https://github.com/WASasquatch/was-node-suite-comfyui/
# git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
# git clone https://github.com/pythongosssss/ComfyUI-WD14-Tagger
# git clone https://github.com/Fannovel16/comfyui_controlnet_aux/
# cd /
# source venv/bin/activate
# cd /workspace/ComfyUI/custom_nodes
# python -m pip install opencv-python
# cd /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui
# pip install -r requirements.txt

# cd /workspace/ComfyUI/custom_nodes
# cd /workspace/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
# # python install.py
# git submodule update --init --recursive


# cd /workspace/ComfyUI/custom_nodes
# cd /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger
# pip install -r requirements.txt


# cd /workspace/ComfyUI/custom_nodes
# cd comfyui_controlnet_aux
# pip install -r requirements.txt



# --------需要安装依赖的节点 END ------



# Install ComfyUI-to-Python
cd /workspace/ComfyUI
git clone https://github.com/pydn/ComfyUI-to-Python-Extension.git
cd ComfyUI-to-Python-Extension
pip install -r requirements.txt

# Import times for custom nodes:
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Image-Selector
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Embedding_Picker
#    0.0 seconds (IMPORT FAILED): /workspace/ComfyUI/custom_nodes/.ipynb_checkpoints
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Advanced-ControlNet
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Custom-Scripts
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-AnimateDiff-Evolved
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI_ADV_CLIP_emb
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI_UltimateSDUpscale
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/comfyui_controlnet_aux
#    0.0 seconds: /workspace/ComfyUI/custom_nodes/Derfuu_ComfyUI_ModdedNodes
#    0.1 seconds: /workspace/ComfyUI/custom_nodes/AIGODLIKE-COMFYUI-TRANSLATION
#    0.1 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-WD14-Tagger
#    0.1 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Manager
#    0.3 seconds: /workspace/ComfyUI/custom_nodes/SeargeSDXL
#    1.4 seconds: /workspace/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
#    1.9 seconds: /workspace/ComfyUI/custom_nodes/was-node-suite-comfyui



echo -e "${GREEN}===========================\n${NC}"
echo -e "${GREEN}预先下载一些Civitai和Huggingface的资源${NC}"
echo -e "${GREEN}Pre-download some resources from Civitai and Huggingface.${NC}"


civitai_res_array=()

# Download from Civital





## Checkpoint model

### SDXL
# civitai_res_array+=("https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors /workspace/ComfyUI/models/checkpoints")
# civitai_res_array+=("https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors /workspace/ComfyUI/models/checkpoints")

### realistic XL with 1.5
# civitai_res_array+=("https://civitai.com/models/4201/realistic-vision-v20")

# civitai_res_array+=("https://civitai.com/models/139562/realvisxl-v20")

# ### ReV-Animated-EOL-1.2.2
# civitai_res_array+=("https://civitai.com/models/7371/rev-animated?modelVersionId=46846")

# ### Counterfeit-V3.0
# civitai_res_array+=("https://civitai.com/models/4468")

# ### CuteYukiMix
# civitai_res_array+=("https://civitai.com/models/28169/cuteyukimixadorable-style?modelVersionId=195410")


### majicMIX realistic
# civitai_res_array+=("https://civitai.com/models/43331")

### beautiful-realistic-asians
# civitai_res_array+=("https://civitai.com/models/25494/beautiful-realistic-asians")

### epiCRealism
# civitai_res_array+=("https://civitai.com/models/25694/epicrealism")


## embeddings

### easynegative.safetensors
# civitai_res_array+=("https://civitai.com/api/download/models/9208")

### badhandv4.pt
# civitai_res_array+=("https://civitai.com/api/download/models/20068")

### bad-picture-negative
# civitai_res_array+=("https://civitai.com/models/17083/bad-picture-negative-embedding-for-chilloutmix")

# BadDream.pt
# civitai_res_array+=("https://civitai.com/models/72437?modelVersionId=77169")



# Download from  Huggingface
## upscale
# civitai_res_array+=("https://huggingface.co/embed/upscale/resolve/main/4x-UltraSharp.pth /workspace/ComfyUI/models/upscale_models")
# civitai_res_array+=("https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth /workspace/ComfyUI/models/upscale_models")


## VAE
# civitai_res_array+=("https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors /workspace/ComfyUI/models/vae")

## controlnet model 先不下载

### openpose
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth /workspace/ComfyUI/models/controlnet")
# ### tile
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth /workspace/ComfyUI/models/controlnet")
# ### qrcode_monster
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/v2/control_v1p_sd15_qrcode_monster_v2.yaml /workspace/ComfyUI/models/controlnet")
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/v2/control_v1p_sd15_qrcode_monster_v2.safetensors /workspace/ComfyUI/models/controlnet")
# ### qrcode_monster_v1
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/control_v1p_sd15_qrcode_monster.yaml /workspace/ComfyUI/models/controlnet")
# civitai_res_array+=("https://huggingface.co/monster-labs/control_v1p_sd15_qrcode_monster/resolve/main/control_v1p_sd15_qrcode_monster.safetensors /workspace/ComfyUI/models/controlnet")

# ### control_v11p_sd15_inpaint
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_inpaint.pth /workspace/ComfyUI/models/controlnet")
# civitai_res_array+=("https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_inpaint.yaml /workspace/ComfyUI/models/controlnet")

### qr_code 
# civitai_res_array+=("https://huggingface.co/DionTimmer/controlnet_qrcode-control_v1p_sd15/resolve/main/control_v1p_sd15_qrcode.safetensors /workspace/ComfyUI/models/controlnet")
# civitai_res_array+=("https://huggingface.co/DionTimmer/controlnet_qrcode-control_v1p_sd15/resolve/main/control_v1p_sd15_qrcode.yaml /workspace/ComfyUI/models/controlnet")

# civitai_res_array+=("https://huggingface.co/TencentARC/t2i-adapter-canny-sdxl-1.0/resolve/main/diffusion_pytorch_model.fp16.safetensors /workspace/ComfyUI/models/controlnet")


# AnimateDiff Model
# civitai_res_array+=("https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15_v2.ckpt /workspace/ComfyUI/custom_nodes/ComfyUI-AnimateDiff/models")

# # gligen_models
# civitai_res_array+=("https://huggingface.co/comfyanonymous/GLIGEN_pruned_safetensors/resolve/main/gligen_sd14_textbox_pruned_fp16.safetensors /workspace/ComfyUI/models/gligen")

# clip_vision
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/pytorch_model.bin /workspace/ComfyUI/models/clip_vision")


# ComfyUI_IPAdapter_plus_clip_vision
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors /workspace/ComfyUI/models/clip_vision")
#创建一下 SDXL 文件夹
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/image_encoder/model.safetensors /workspace/ComfyUI/models/clip_vision/SDXL/")

# IPAdapter-ComfyUI
## adapter_sd15
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.bin /workspace/ComfyUI/custom_nodes/IPAdapter-ComfyUI/models")

# ComfyUI_IPAdapter_plus
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/blob/main/models/ip-adapter_sd15_light.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")
# civitai_res_array+=("https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.bin /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus/models")

# unClip

# civitai_res_array+=("https://huggingface.co/comfyanonymous/wd-1.5-beta2_unCLIP/resolve/main/wd-1-5-beta2-aesthetic-unclip-h-fp16.safetensors /workspace/ComfyUI/models/checkpoints")
# wget https://huggingface.co/comfyanonymous/wd-1.5-beta2_unCLIP/resolve/main/wd-1-5-beta2-aesthetic-unclip-h-fp16.safetensors

for element in "${civitai_res_array[@]}"; do
    handleCode "$element"
done



echo -e "\n${GREEN}Done!${NC}"