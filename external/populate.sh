#!/bin/bash
DIR=$(cd -P $(dirname "${BASH_SOURCE[0]}") && pwd)

url_prefix="http://mat.gsia.cmu.edu/COLOR02/INSTANCES/"
file_names=( "GEOM20.col" )

pushd ${DIR}

for file_name in "${file_names[@]}"
do
  curl -O $url_prefix$file_name
done

popd
