pipeline {
    agent any

    environment {
        // ต้องเปลี่ยนค่าเหล่านี้:
        GITHUB_USERNAME = 'jupiter778'
        GITHUB_REPO = 'node_test_jenkins'
        GHCR_CREDENTIALS_ID = 'token-github'
        
        // ตัวแปรที่ใช้ร่วมกัน
        GHCR_REGISTRY = 'ghcr.io'
        IMAGE_FULL_NAME = "${GHCR_REGISTRY}/${GITHUB_USERNAME}/${GITHUB_REPO}"
        CI = 'true'
    }

    stages {
        stage('Install & Test') {
            steps {
                sh 'npm install' 
            }
        }

        stage('Build Image') {
            steps {
                // Build และ Tag ด้วย Build Number และ Latest
                sh "docker build -t ${IMAGE_FULL_NAME}:${env.BUILD_NUMBER} ."
                sh "docker tag ${IMAGE_FULL_NAME}:${env.BUILD_NUMBER} ${IMAGE_FULL_NAME}:latest"
            }
        }
        
        stage('Push to GHCR') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${env.GHCR_CREDENTIALS_ID}", passwordVariable: 'GHCR_TOKEN', usernameVariable: 'GHCR_USER'
                )]) {
                    // Login, Push
                    sh "echo ${GHCR_TOKEN} | docker login ${GHCR_REGISTRY} -u ${GHCR_USER} --password-stdin"
                    sh "docker push ${IMAGE_FULL_NAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${IMAGE_FULL_NAME}:latest"
                    // docker logout ถูกตัดออกเพื่อความเรียบง่าย
                }
            }
        }
    }

    post {
        always {
            cleanWs() /
        }
    }
}