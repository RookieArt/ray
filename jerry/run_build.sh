#!/usr/bash -l

set -ex

export http_proxy=http://10.74.176.8:11080 https_proxy=http://10.74.176.8:11080 HTTP_PROXY=http://10.74.176.8:11080 HTTPS_PROXY=http://10.74.176.8:11080 no_proxy=".corp.kuaishou.com,10.*.*.*,172.*.*.*,*.local,localhost,127.0.0.1" NO_PROXY=".corp.kuaishou.com,10.*.*.*,172.*. *.*,*.local,localhost,127.0.0.1"


# !!! PLEASE SET TARGET TO `opt` or `dbg` CAREFULLY !!!
#TARGET=opt
TARGET=dbg

echo "build target: ${TARGET}"

# conda
eval "$(conda shell.bash hook)"
source ~/miniconda3/etc/profile.d/conda.sh

if [[ "x${TARGET}" == "xopt" ]]; then
  conda activate ray_local_opt
elif [[ "x${TARGET}" == "dbg" ]]; then
  conda activate ray_local
  export RAY_DEBUG_BUILD=debug
else
  echo "ERROR!!! target not supportted: ${TARGET}, quit"
  exit 1
fi

# clean
cd python && bazel clean --expunge && cd -

# build dashboard
#cd dashboard/client && npm ci && npm run build && cd ../..

# dependencies
#cd python && pip install -r requirements.txt && cd -

# build ray-cpp
cd python && RAY_INSTALL_CPP=1 pip install -e . --verbose && cd -
# build ray
cd python && pip install -e . --verbose && cd -

# compile_commands.json
#bazel run @hedron_compile_commands//:refresh_all
