pipeline {
    agent any

    environment {
        REPO_URL           = "https://github.com/jupiter778/node_test_jenkins.git"
        LOCAL_IMAGE_NAME   = "myapp"
        LOCAL_TAG          = "latest"
        AWS_ACCOUNT_ID     = "822334816473"           // แก้เป็น AWS account ของคุณ
        AWS_REGION         = "ap-southeast-1"        // เช่น ap-southeast-1
        ECR_REPO           = "test-repo"             // ชื่อ repo ใน AWS ECR
        ECR_URI            = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${LOCAL_TAG}"
        DOCKER_REPO        = "cnwsb777/test-docker"
        DOCKER_TAG         = "yoo_ibowww"
        DOCKER_HUB_USER    = "cnwsb777"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git credentialsId: 'token-aws', url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                echo "Building Docker Image..."
                docker build -t ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} .
                '''
            }
        }

        stage('Tag Image for AWS ECR') {
            steps {
                sh '''
                echo "Tagging image for AWS ECR..."
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${ECR_URI}
                '''
            }
        }

        stage('Login to AWS ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                    echo "Logging in to AWS ECR..."
                    aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                    '''
                }
            }
        }

         stage('Push to AWS ECR') {
            steps {
                sh '''
                echo "Pushing Docker image to AWS ECR..."
                docker push ${ECR_URI}
                '''
            }
        }
        }
    }

