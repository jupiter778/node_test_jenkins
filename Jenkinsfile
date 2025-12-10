pipeline {
    agent any
    stages {
        stage('Pull Code') {
            steps {
                git branch: 'main', url: 'https://github.com/jupiter778/node_test_jenkins.git'
            }
        }
        stage('Install') {
            steps {
                bat 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                bat 'npm test'
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
}
...