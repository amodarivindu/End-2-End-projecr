pipeline {
    agent any

    environment {
        IMAGE = "yourdockerhub/app"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t $IMAGE .'
            }
        }

        stage('Push Image') {
            steps {
                bat 'docker push $IMAGE'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                dir('ansible') {
                    bat 'ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }
    }
}