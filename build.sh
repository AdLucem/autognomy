#!/bin/bash

build_using_stack() {
	cd $1
	stack build
}

build_using_stack startup
build_using_stack hashtag-aesthetic
build_using_stack project_manager
