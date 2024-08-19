## End-to-End CI/CD Pipeline with Jenkins, SonarQube, Argo CD, Helm, and Kubernetes

This repository contains all the necessary configurations to set up an end-to-end CI/CD pipeline for a Python application. The pipeline is designed to automate the entire process, from code checkout to production deployment, using Jenkins, SonarQube, Argo CD, Helm, and Kubernetes.

<img width="987" alt="Screenshot 2024-08-18 at 11 15 11 PM" src="https://github.com/user-attachments/assets/dfe4d4f3-6abc-4225-a617-ea537bd92eb8">

### Prerequisites
Before you begin, ensure you have the following:

Jenkins Server installed and running.
GitHub Account with repositories for both application code and Kubernetes manifests.
Docker installed on Jenkins nodes.
Kubernetes Cluster with access to deploy resources.
Argo CD installed on the Kubernetes cluster.
SonarQube server installed and accessible.

### Pipeline Overview
Step 1: Install Jenkins server and set up webhooks with GitHub.
Step 2: Install necessary Jenkins plugins and integrate security and testing tools like SonarQube.
Step 3: Install Kubernetes cluster with Argo CD operator. Create YAML files for all components.
Step 4: Commit to the GitHub repo, triggering the Jenkins pipeline. After a successful build, it will update the manifests repo. Argo CD will automatically trigger on the commit and fetch the new image from the artifact repo.

### Setup Instructions
**Step 1**: Install Jenkins Server and Set Up Webhooks with GitHub
Install Jenkins:
```
sudo apt update
sudo apt install openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

Set Up Webhooks in GitHub:
Go to your GitHub repository.
Navigate to Settings > Webhooks > Add Webhook.
Set the payload URL to your Jenkins server's webhook URL: http://your-jenkins-server/github-webhook/.
Choose application/json as the content type and make sure the webhook is set to trigger on push events.

**Step 2**: Install Necessary Jenkins Plugins and Integrate SonarQube
Install Jenkins Plugins:
Navigate to Jenkins Dashboard > Manage Jenkins > Manage Plugins.
Install the following plugins:
GitHub Integration Plugin
Docker Pipeline Plugin
SonarQube Scanner Plugin
Kubernetes Continuous Deploy Plugin
Argo CD Plugin

Configure SonarQube in Jenkins:
Navigate to Jenkins Dashboard > Manage Jenkins > Configure System.
In the SonarQube section, add a new SonarQube installation and provide the necessary details such as the server URL and authentication token.

**Step 3**: Install Kubernetes Cluster with Argo CD Operator
Install Argo CD on Your Kubernetes Cluster:
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
Access Argo CD UI:
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Access the UI via https://localhost:8080.
Create YAML Files for Kubernetes Components (deployment.yaml, service.yaml, argocd-app.yaml)

**Step 4**: Commit to GitHub Repo and Trigger Jenkins Pipeline
Create a Jenkins Pipeline

Commit Changes to GitHub:
Push your code and manifest changes to GitHub.
Jenkins will automatically start the pipeline due to the webhook.

Monitor Argo CD for Deployment:
Argo CD will automatically detect the changes in the manifest repository and start deploying the updated image to your Kubernetes cluster.
You can monitor the deployment process through the Argo CD UI.
