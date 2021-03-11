qf-path := ../../Repos/quickfeed

local-server:
	make local-docker -C $(qf-path)

local-server-build:
	@echo Building and starting local server in docker container
	sudo ${compose-path} up --build
