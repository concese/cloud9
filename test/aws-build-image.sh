# Script to build new AMI, used by packer for testing.
#
# Usage:
# - Create new empty cloud9 environmentE
# - Execute this script to generate new AMI

echo -n "Username:"
read username
description="Generated by ${username} at $(date +%s)"

### Pre-download docker images  ###
docker pull fpfis/fpfis-base
docker pull phpmyadmin/phpmyadmin
docker pull fpfis/solr5
docker pull djfarrelly/maildev
docker pull rediscommander/redis-commander
docker pull redis
docker pull dougw/novnc
docker pull selenium/standalone-chrome-debug

###  Pre-fill composer cache  ### 
# install needed tools
sudo yum install php56-gd -y
sudo sed -i 's/memory_limit = 128M/memory_limit = 2048M/g' /etc/php-5.6.ini
wget https://getcomposer.org/installer -O /tmp/installer
php /tmp/installer --force --filename=composer --version=1.9.3
# run composer commands
php composer create-project drush/drush:8 drush8
php composer create-project drush/drush:9 drush9
echo "Y" | php composer create-project drupal-composer/drupal-project:7.x-dev drupal7
echo "Y" | php composer create-project drupal-composer/drupal-project:8.x-dev drupal8
# clean installed tools
rm -Rf drupal7 drupal8 drush8 drush9 composer /tmp/installer
sudo yum remove php56-gd -y

### Create image  ###
aws ec2 create-image \
--name="aws-cloud9-packer-template-$(date +%s)" \
--instance-id="$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" \
--description="$description"

