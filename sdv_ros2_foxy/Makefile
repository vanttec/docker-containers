sdv.build:
	@docker build -t ros/sdv:sdv_docker -f Dockerfile .
sdv.up:
	@xhost +
	@docker start sdv
sdv.down:
	@xhost +
	@docker stop sdv
sdv.restart:
	@xhost +
	@docker restart sdv
sdv.shell:
	@xhost +	
	@docker exec -it sdv bash
sdv.nvidiacreate:
	@./runNvidiaGpu.bash
sdv.intelcreate:
	@./runIntelGpu.bash