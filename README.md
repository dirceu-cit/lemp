# LEMP

Linux Nginx MySql and PHP. This is a docker composition which will support our Magento DEV Environment. I created it in order to have somewhere to test the deployment scripts that will be executed in the Azure's Magento VMs. Bringing it to docker, we can run an infra-structure easily in our local environment and then focus in the other important things, which is the automatic deployment that should run on a Jenkins App. Here we have three linked containers: mysql:latest, nginx:latest and php-fpm:7.0. The last one contains the Magento 2.1.9 installed. 

To run it, you must get an `auth.json` file containing the access keys for download Magento from its official site. Ask for your tech leader about how to get it. After that, put this file into the `php` folder and run the command `docker-compose up`. It takes a while at the first time to create the image with magento included, but in the end you will have a webserver listening on 80 port of docker host machine (usually localhost). You can test the frontend access accessing http://localhost

### TODOs:
- [x] Do the docker-container working with Magento-2 CE
- [x] Change Comunity Edition by Enterprise Edition 
- [x] Externalize the Magento credentials as a docker build args picked from host environment-variable
- [x] Fix the 404 error for the magento's static files (css, js)
- [ ] Create the proper Package Manager to provide the php modules (better if could be the Nexus)
- [ ] Pull and deploy the customized code
- [ ] Create the jenkins and the deployment process
- [ ] Make the same deployment process working for Azure VMs
- [ ] Restrict the access for VMs
- [ ] Build the SCM process based on Pull Request First
- [ ] Create a health-check for each container, specially the php one.