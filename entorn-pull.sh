#!/bin/bash

ver="0.1.0"

if [ ! -z "$1" ]; then 
   ver="$1"   
fi

echo "Updating entorn to version $ver"

local_base_name=entorn-io/singleuser
remote_base_name=pluralcamp/entorn-io

error=false

pull_image() {
if ! docker pull ${remote_base_name}-$1:$ver 2>/dev/null ; then
	error=true;
fi
docker tag ${remote_base_name}-$1:$ver $local_base_name-$1:${ver} 2>/dev/null
docker rmi ${remote_base_name}-$1:$ver 2>/dev/null
}

#pull_image dev
#pull_image data
#pull_image ops
pull_image javaweb

if ! docker pull ${remote_base_name}-hub-lti:$ver 2>/dev/null ; then
	error=true
fi
docker tag ${remote_base_name}-hub-lti:$ver entorn-io/hub-lti:${ver} 2>/dev/null
docker rmi ${remote_base_name}-hub-lti:$ver 2>/dev/null

if ! docker pull ${remote_base_name}-dind:$ver 2>/dev/null ; then
	error=true
fi
docker tag ${remote_base_name}-dind:$ver entorn-io/dind:${ver} 2>/dev/null 
docker rmi ${remote_base_name}-dind:$ver 2>/dev/null

remove_other (){
	docker rmi -f $local_base_name-$1:$ver
}

remove_other dev
remove_other data
remove_other ops

docker images | grep entorn | grep "$ver"

echo
if [ "$error" == "false" ]; then 
	echo "All entorn images pulled successfully."
else
	echo "Error in pulling one or more images."
	echo "Please run $0 again."
fi
echo

exit 0
