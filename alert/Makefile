.PHONY: sequence clean

SOURCE_PATH=function
DEST_PATH=archive
DEST_NAME=notifier

sequence: deploy
	rm -rf ${DEST_PATH}

deploy: init build
	terraform apply

dep:
	GO111MODULE=on go mod download

build:
	cd ./${SOURCE_PATH}; \
	GO111MODULE=on go mod download; \
	GOOS=linux go build -o ../${DEST_PATH}/${DEST_NAME}

init:
	terraform init

clean:
	terraform destroy
