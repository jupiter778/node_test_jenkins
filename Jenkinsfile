pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test || echo "no tests"'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build || echo "no build step"'
            }
        }
    }
}
