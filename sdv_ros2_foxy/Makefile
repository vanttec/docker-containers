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
	@docker start sdv_port_container
sdvport.down:+
	@docker stop sdv_port_container
sdvport.restart:
	@docker restart sdv_port_container
sdvport.shell:	
	@docker exec -it sdv_port_container bash
sdvport.nvidiacreate:
	@./runNvidiaGpuPort.bash
sdvport.intelcreate:
	@./runIntelGpu.bash



