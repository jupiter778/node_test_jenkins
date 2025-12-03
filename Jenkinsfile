pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://gitlab.com/meng_gitlab-group/my_project_test.git'
            }
        }
        stage('Install') {
            steps {
                bat 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build') {
            steps {
                bat 'echo "No build step, skipping"'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("mynodeapp:latest")
                }
            }
        }
    }
}//ทดสอบ
