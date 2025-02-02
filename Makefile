.PHONY: default laptop desktop work test

test:
	vagrant destroy -f && vagrant up && vagrant ssh -t -- "/vagrant/install-profile default && /vagrant/install-profile laptop"

default:
	./install-profile default

laptop: default
	./install-profile laptop

desktop: default
	./install-profile desktop

work: default
	./install-profile work
