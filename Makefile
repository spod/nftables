all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_arm64.tar: Dockerfile
	docker build --rm -t nftables .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z nftables sh -c 'chown -R 1000:1000 /tmp/freeze/freeze*.tar && cp /tmp/freeze/freeze*.tar /tmp/gokrazy/extrafiles_arm64.tar'

_gokrazy/extrafiles_amd64.tar: Dockerfile.amd64
	docker build --rm -t nftables --file Dockerfile.amd64 .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z nftables sh -c 'chown -R 1000:1000 /tmp/freeze/freeze*.tar && cp /tmp/freeze/freeze*.tar /tmp/gokrazy/extrafiles_amd64.tar'

clean:
	rm -f _gokrazy/extrafiles_*.tar
