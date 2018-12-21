defaultmake:
	mv -v bind/templates/example.internal.zone.j2 bind/templates/$(MY_ZONE).zone.j2
	sed -i 's/example.internal/$(MY_ZONE)' bin/vars/main.yml test/run.sh bind/vars/main.yml

test_static:
	shellcheck test/run.sh
	ansible-playbook --syntax-check bind.yml
	ansible-playbook --syntax-check test/test.yml

build:
	docker build -t dns-test -f Dockerfile .

teardown:
	-docker rm -f dns-test

test: build teardown
	docker run -d --name dns-test --dns=127.0.0.1 dns-test:latest
	docker exec -t dns-test ansible-playbook test/test.yml -i test/inventory
	docker exec -t dns-test /usr/sbin/rndc reload
	docker exec -t dns-test cat /etc/resolv.conf
	docker exec -t dns-test bash test/run.sh

deploy:
	ansible-playbook bind.yml

healthcheck:
	bash test/run.sh
