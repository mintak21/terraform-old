.PHONY: setup_mac fmt

fmt:
	terraform fmt -recursive

setup_mac:
	sh scripts/setup/macOS/setup.sh
