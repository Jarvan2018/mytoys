#!/bin/bash
source shared.sh


# 获取脚本所在的目录
current_script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


cd /workspace
mkdir MyGoogleDrive
git clone https://github.com/comfyanonymous/ComfyUI
python -m venv myenv --prompt ComfyUI
# 使用python虚拟环境
source myenv/bin/activate
cd ComfyUI
pip install xformers!=0.0.18 -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu118 --extra-index-url https://download.pytorch.org/whl/cu117

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


echo -e "\n${GREEN}success install ComfyUI!!!${NC}"


echo -e "\n${GREEN}run ComfyUI......${NC}"

# 切换到脚本所在的目录
cd "$current_script_dir"

python setup_cloudflared.py --port 8188
wait

cd /workspace/ComfyUI
source /workspace/myenv/bin/activate
python main.py --dont-print-server