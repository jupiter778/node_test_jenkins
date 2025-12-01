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
                bat 'echo "No tests, skipping"'
            }
        }
        stage('Build') {
            steps {
                bat 'echo "No build step, skipping"'
            }
        }
    }
}
