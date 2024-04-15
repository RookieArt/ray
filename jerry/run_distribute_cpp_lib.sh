#!/bin/bash

set -ex

# version
version=v264

pkg_dir=ray_so.${version}
pkg_tar=ray_so.${version}.tar.gz

pushd python/ray/ && mkdir ${pkg_dir} && cp -r cpp/{lib,include} ${pkg_dir} && tar czvf ${pkg_tar} ${pkg_dir}  && csc upload ${pkg_tar} uploads/tmp/ray/${pkg_tar} && rm -rf ${pkg_dir} ${pkg_tar} && popd

