#!/bin/bash
docker run -v ${PWD}:/workspace -w /workspace mcap mcap $@
