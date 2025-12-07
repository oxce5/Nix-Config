test:
  alejandra . && nh os test

update-test:
  alejandra . && nh os test --update

switch:
  alejandra . && nh os switch

update-switch:
  alejandra . && nh os switch --update

deploy: 
  alejandra . && nh os switch -H chimera --target-host teto@192.168.1.26

update-deploy: 
  alejandra . && nh os switch --update -H chimera --target-host teto@192.168.1.26

test-deploy:
  alejandra . && nh os test -H chimera --target-host teto@192.168.1.26

update-test-deploy: 
  alejandra . && nh os switch --update -H chimera --target-host teto@192.168.1.26

