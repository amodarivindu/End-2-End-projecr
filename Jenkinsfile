pipeline {
    agent any

    environment {
        IMAGE = "yourdockerhub/app"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t amodarivindu/myapp_new ./app'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    bat "docker login -u %USER% -p %PASS%"
                    bat "docker push amodarivindu/myapp_new"
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