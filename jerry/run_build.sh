#!/usr/bash -l

set -ex

export http_proxy=http://10.74.176.8:11080 https_proxy=http://10.74.176.8:11080 HTTP_PROXY=http://10.74.176.8:11080 HTTPS_PROXY=http://10.74.176.8:11080 no_proxy=".corp.kuaishou.com,10.*.*.*,172.*.*.*,*.local,localhost,127.0.0.1" NO_PROXY=".corp.kuaishou.com,10.*.*.*,172.*. *.*,*.local,localhost,127.0.0.1"


if [[ -f ./jerry/env.sh ]]; then
  source ./jerry/env.sh
else
  echo "ERROR!!! please create ./jerry/env.sh and set environment variables in it !!!"
  exit 1
fi

echo "build target: ${TARGET}"

if [[ "x${TARGET}" == "xopt" ]]; then
  export RAY_CONDA_ENV="ray_local_opt"
elif [[ "x${TARGET}" == "xdbg" ]]; then
  export RAY_CONDA_ENV="ray_local"
  export RAY_DEBUG_BUILD=debug
else
  echo "ERROR!!! target not supportted: ${TARGET}, quit"
  exit 1
fi

# conda
set +x
echo "conda activate ${RAY_CONDA_ENV}"
eval "$(conda shell.bash hook)"
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ${RAY_CONDA_ENV}
set -x

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
