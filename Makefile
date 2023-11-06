all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_arm64.tar: Dockerfile
	docker build --rm -t nftables .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z nftables sh -c 'mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/nftables.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/aarch64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/aarch64-linux-gnu/nftables.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && ln -sf /user/nftables /tmp/extrafiles/usr/local/bin/nft && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_arm64.tar *'

_gokrazy/extrafiles_amd64.tar: Dockerfile.amd64
	docker build --rm -t nftables --file Dockerfile.amd64 .
	docker run --rm -v $$(pwd)/_gokrazy/:/tmp/gokrazy/:Z nftables sh -c 'mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/nftables.frozen && mkdir -p /tmp/extrafiles/lib && mkdir -p /tmp/extrafiles/usr/local/bin && mkdir -p /tmp/extrafiles/usr/lib/x86_64-linux-gnu/ && tar xf /tmp/freeze/freeze*.tar -C /tmp/extrafiles/usr/lib/x86_64-linux-gnu/nftables.frozen --strip-components=1 && chown -R 1000:1000 /tmp/extrafiles && ln -sf /user/nftables /tmp/extrafiles/usr/local/bin/nft && cd /tmp/extrafiles && tar cf /tmp/gokrazy/extrafiles_amd64.tar *'

clean:
	rm -f _gokrazy/extrafiles_*.tar
