#!/bin/bash

# Repo Parameters
TAG=latest
REPSITORY=motionsignaltechnologies/madagascar-docker
DOCKERFILE=Dockerfile

# Set the options
DO_PUSH=1
NO_CACHE=1
while getopts ":hbf" opt; do
  case ${opt} in
    h )
      echo "Usage:"
	  echo "    ./build-deploy                        Build, tag and push (default)"
	  echo "    ./build-deploy -b                     Build and tag only "
	  echo "    ./build-deploy -f                     Build (with no cache) "
      echo "    ./build-deploy -h                     Display this help message."
      exit 0
      ;;
	b )
	  DO_PUSH=0
	  ;;
	f )
	  NO_CACHE=0
	  ;;
    \? )
      echo "Invalid Option: -$OPTARG" 1>&2
      exit 1
      ;;
  esac
done

# Build and tag
if [ $NO_CACHE -eq 1 ]
then
	docker build -t ${REPSITORY}:${TAG} -f ${DOCKERFILE} .
else
	docker build --no-cache -t ${REPSITORY}:${TAG} -f ${DOCKERFILE} .
fi

# Push
if [ $DO_PUSH -eq 1 ]
then
	docker push ${REPSITORY}:${TAG}
fi

