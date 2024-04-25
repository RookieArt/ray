#!/bin/bash

set -ex

if [[ -f ./jerry/env.sh ]]; then
  source ./jerry/env.sh
else
  echo "ERROR!!! please create ./jerry/env.sh and set environment variables in it !!!"
  exit 1
fi

echo "build target: ${TARGET}"

rm -f python/dist/*

cd python && RAY_INSTALL_JAVA=1 SKIP_BAZEL_BUILD=1 python setup.py -q bdist_wheel && cd -
cd python && RAY_INSTALL_JAVA=1 RAY_INSTALL_CPP=1 SKIP_BAZEL_BUILD=1 python setup.py -q bdist_wheel && cd -

# upload ray
cd python/dist && fp_ray=`echo ray-*.whl` && csc upload ${fp_ray} uploads/tmp/ray/${TARGET}/${fp_ray} && cd -
# upload ray_cpp
cd python/dist && fp_ray=`echo ray_cpp-*.whl` && csc upload ${fp_ray} uploads/tmp/ray/${TARGET}/${fp_ray} && cd -

