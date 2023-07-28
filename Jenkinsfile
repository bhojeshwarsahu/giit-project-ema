pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('sahu')
        GIT_CREDENTIALS = credentials('sahu-github')
        DOCKER_IMAGE_NAME1 = "bhojeshwarsahu/frontend:latest"
        DOCKER_IMAGE_NAME2 = "bhojeshwarsahu/mysql:latest"
        DOCKER_IMAGE_NAME3 = "bhojeshwarsahu/backend:latest"
    }
	
stages {
        stage('Git Clone') {
    steps {
        echo "Cloning the Node.js project from Git..."
        git branch: 'master', credentialsId: 'sahu-github', url: 'git@github.com:bhojeshwarsahu/giit-project-ema.git'
    }
}

		
		stage('Docker Build') {
            steps {
                echo "Building Docker images..."
                script {
                    sh "pwd"
                    sh "docker build -t $DOCKER_IMAGE_NAME1 frontend/"
                    sh "docker build -t $DOCKER_IMAGE_NAME2 mysql/"
                    sh "docker build -t $DOCKER_IMAGE_NAME3 backend/"
                }
            }
        }
		
		stage('Login to Docker Hub') {
            steps {
                echo "Logging in to Docker Hub..."
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
		
		stage('Push Docker Images') {
            steps {
                echo "Pushing Docker images to the registry..."
                script {
                    sh "docker push $DOCKER_IMAGE_NAME1"
                    sh "docker push $DOCKER_IMAGE_NAME2"
                    sh "docker push $DOCKER_IMAGE_NAME3"
                }
            }
        }
		
		stage('Deploy to Minikube') {
            environment {
                kubeConfigCredential = 'sahu-kubernetes-secrets'
            }
            steps {
                script {
                    def rootDir = "/var/lib/jenkins/workspace/giit-project-ema"
                    def frontendDir = "${rootDir}/frontend"
                    def mysqlDir = "${rootDir}/mysql"
                    def backendDir = "${rootDir}/backend"
                    
                    sh "pwd"
                    sh "cd ${frontendDir} && helm package frontend-chart --version 0.1.0"
                    sh "cd ${mysqlDir} && helm package mysql-chart --version 0.1.0"
                    sh "cd ${backendDir} && helm package backend-chart --version 0.1.0"
                }
            }
        }
		
		stage('Git Push to Origin') {
        steps {
            withCredentials([sshUserPrivateKey(credentialsId: 'sahu-github', keyFileVariable: 'SSH_KEY')]) {
                sh "git config --global user.name 'bhojeshwar sahu'"
				sh "echo \$?"
                sh "git config --global user.email 'bhojeshwarsahu123@gmail.com'"
				sh "echo \$?"

                sh "git add frontend/frontend-chart-0.1.0.tgz"
				sh "echo \$?"
                sh "git add mysql/mysql-chart-0.1.0.tgz"
				sh "echo \$?"
                sh "git add backend/backend-chart-0.1.0.tgz"
				sh "echo \$?"

                sh "git commit -m 'Updated Helm Charts'"
				sh "echo \$?"
                sh("git push origin master")
                sh "echo \$?"
				}
			}
		}
	}		
}		
