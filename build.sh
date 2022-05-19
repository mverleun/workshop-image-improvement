#!/bin/bash
CONTEXT="."
TAG="workshop"
DOCKERFILE="Dockerfile.local"


docker build -f $DOCKERFILE -t $TAG $CONTEXT
