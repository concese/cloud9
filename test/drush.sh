# Include Drush bash customizations.
if [ -f "$HOME/.drush/drush.bashrc" ] ; then
  source /home/ec2-user/.drush/drush.bashrc
fi

# Include Drush completion.
if [ -f "$HOME/.drush/drush.complete.sh" ] ; then
  source /home/ec2-user/.drush/drush.complete.sh
fi

# Include Drush prompt customizations.
if [ -f "$HOME/.drush/drush.prompt.sh" ] ; then
  source /home/ec2-user/.drush/drush.prompt.sh
fi