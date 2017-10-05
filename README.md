# LEMP

Linux Nginx MySql and PHP. This is a docker composition which will support our Magento DEV Environment. I created it in order to have somewhere to test the deployment scripts that we will execute in the Azure Magento VMs. Bringing it to docker, we can run an infra-structure easily in our local environment and then focus in the other important things, which is the automatic deployment that should run on a Jenkins App. 

Here we have three linked containers, which are running nginx, php-fpm-7 and MySql:latest. Running `docker-compose up` you are going to have an webserver listening on 80 port of docker host machine (usually localhost). You can test it accessing http://localhost/index.html

Still missing the Magento 2.1 installation, which is the next step before start to work on the deployment scripts. 

Here is what I want to do: http://devdocs.magento.com/guides/v2.0/install-gde/install-flow-diagram.html
