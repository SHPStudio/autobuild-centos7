#!/bin/bash
source ./config.ini
rm -rf $project_path/* $project_path/.* $docker_build_path/shape.jar
echo "done"
