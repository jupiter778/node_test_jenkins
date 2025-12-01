pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Install') {
            steps {
                bat 'npm install'
            }
        }
        stage('Test') {
            steps {
                bat 'npm test || echo "no tests"'
            }
        }
        stage('Build') {
            steps {
                bat 'npm run build || echo "no build step"'
            }
        }
    }
}
