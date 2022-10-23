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


sdvport.build:
	@docker compose up
sdvport.up:
	@xhost +
	@docker start sdv_port
sdvport.down:
	@xhost +
	@docker stop sdv_port
sdvport.restart:
	@xhost +
	@docker restart sdv_port
sdvport.shell:
	@xhost +	
	@docker exec -it sdv_port bash
sdvport.nvidiacreate:
	@./runNvidiaGpuPort.bash
sdvport.intelcreate:
	@./runIntelGpu.bash



