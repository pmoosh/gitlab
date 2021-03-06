# GitLab
An easy to use GitLab container based on the [Depend on Docker](https://github.com/iankoulski/depend-on-docker) project. 

## Basic configuration


    docker container run -d --name gitlab -p 80:80 -p 2222:22 -v gitlab-config:/etc/gitlab gitlab-logs:/var/log/gitlab -v gitlab-data:/var/opt/gitlab iankoulski/gitlab:12.5.2-ce.0


This command will start GitLab and expose its web UI on port 80 and git ssh endpoint on port 2222. All configuration, logs, and data will be stored in named Docker volumes. Only basic features (source control) will be enabled.

## Advanced configuration

More flexibility in configuration can be achieved by cloning the iankoulski/gitlab repo.

    git clone https://github.com/iankoulski/gitlab.git

Modify settings in the .env file per your requirements, then execute the run script to start gitlab.

    ./run.sh

This command will start GitLab with SSL and Docker registry enabled. By default, the UI will be exposed on port 443 and the Docker registry on port 446.

## Initial Login

Once the GitLab instance is fully initialized, you may navigate to https://<GITLAB_HOSTNAME>

<p align="center"><img alt="GitLab Initial Login" src="https://github.com/iankoulski/gitlab/raw/master/doc/img/screenshot-gitlab-login1.png" width="90%" align="center"/></p>

You will be asked to create a password. Then you can use user "root" and the password you created to log in for the first time.

## Technical details

This container image is based on gitlab/gitlab-ce with one modification. File /opt/gitlab/embedded/cookbooks/postgresql/resources/user.rb is modified to extend the time that the startup script waits for the PostgreSQL database to come online. This avoids startup failures that may occur when the database is recovering from an unexpected shutdown like the one that occurs when the GitLab container restarts. Also, the stop.sh script in the [iankoulski/gitlab](https://github.com/iankoulski/gitlab) project gracefully shuts down the database before removing the container. This resolves [issue 893](https://gitlab.com/gitlab-org/gitlab-foss/issues/893) as reported in the [GitLab Org](https://gitlab.com/gitlab-org) open source repository.

Upon initial startup in the advanced configuration, self-signed SSL certificates are generated for both GitLab and the Docker registry. These certificates are stored in wd/gitlab/config/ssl and can be replaced if needed. To set the location where GitLab configuration, logs, or data is stored, simply edit the provided .env file.

