.PHONY: sequence clean

SOURCE_PATH=function
DEST_PATH=archive
DEST_NAME=notifier

sequence: deploy
	rm -rf ${DEST_PATH}

deploy: build fmt init
	terraform apply

dep:
	GO111MODULE=on go mod download

build:
	cd ./${SOURCE_PATH}; \
	GO111MODULE=on go mod download; \
	GOOS=linux go build -o ../${DEST_PATH}/${DEST_NAME}

fmt:
	terraform fmt -recursive

init:
	terraform init

clean:
	terraform destroy
