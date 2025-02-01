.PHONY: test

all:
	./install 

test:
	vagrant destroy -f && vagrant up && vagrant ssh -t -- "bash /vagrant/install"
