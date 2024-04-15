set -ex

export http_proxy=http://10.74.176.8:11080 https_proxy=http://10.74.176.8:11080 HTTP_PROXY=http://10.74.176.8:11080 HTTPS_PROXY=http://10.74.176.8:11080 no_proxy=".corp.kuaishou.com,10.*.*.*,172.*.*.*,*.local,localhost,127.0.0.1" NO_PROXY=".corp.kuaishou.com,10.*.*.*,172.*. *.*,*.local,localhost,127.0.0.1"

# clean
cd python && bazel clean --expunge && cd -

# build dashboard
#cd dashboard/client && npm ci && npm run build && cd ../..

# dependencies
#cd python && pip install -r requirements.txt && cd -

# build ray-cpp
#export RAY_DEBUG_BUILD=
export RAY_DEBUG_BUILD=debug
cd python && RAY_INSTALL_CPP=1 pip install -e . --verbose && cd -
# build ray
cd python && pip install -e . --verbose && cd -

# compile_commands.json
#bazel run @hedron_compile_commands//:refresh_all
