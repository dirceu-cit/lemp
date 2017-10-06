# LEMP

Linux Nginx MySql and PHP. This is a docker composition which will support our Magento DEV Environment. I created it in order to have somewhere to test the deployment scripts that we will execute in the Azure Magento VMs. Bringing it to docker, we can run an infra-structure easily in our local environment and then focus in the other important things, which is the automatic deployment that should run on a Jenkins App. 

Here we have three linked containers, which are running nginx, php-fpm-7 and MySql:latest. Running `MAGENTO_REPO_CREDENTIAL="<your_magento_appkey>:<your_magento_appsecret>" docker-compose up` you are going to have an webserver listening on 80 port of docker host machine (usually localhost). You can test it accessing http://localhost/index.html

Here is what I want to do: http://devdocs.magento.com/guides/v2.0/install-gde/install-flow-diagram.html

### TODOs:
- [x] Do the docker-container working with Magento-2 CE
- [ ] Change Comunity Edition by Enterprise Edition 
- [x] Externalize the Magento credentials as a docker build args picked from host environment-variable
- [ ] Fix the 404 error for the magento's static files (css, js)
- [ ] Create the proper Package Manager to provide the php modules (better if could be the Nexus)
- [ ] Pull and deploy the customized code
- [ ] Create the jenkins and the deployment process
- [ ] Make the same deployment process working for Azure VMs
- [ ] Restrict the access for VMs
- [ ] Build the SCM process based on Pull Request First



