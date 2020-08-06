.PHONY: setup_aws alert setup_mac fmt

setup_aws: setup_mac alert ci

alert:
	cd alert; make

ci:
	cd cicd; make

fmt:
	terraform fmt -recursive

setup_mac:
	sh scripts/setup/macOS/setup.sh
