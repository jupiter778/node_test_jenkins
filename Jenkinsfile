pipeline {
    agent any

    environment {
        REPO_URL         = "https://github.com/jupiter778/node_test_jenkins.git"
        LOCAL_IMAGE_NAME = "myapp"
        LOCAL_TAG        = "latest"

        // AWS ECR
        AWS_ACCOUNT_ID   = "822334816473"
        AWS_REGION       = "ap-southeast-1"
        ECR_REPO         = "test-repo"
        ECR_URI          = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${LOCAL_TAG}"

        // Docker Hub
        DOCKER_REPO      = "cnwsb777/test-docker"
        DOCKER_TAG       = "latest"
        DOCKER_HUB_USER  = "cnwsb777"
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
                withAWS(region: "${AWS_REGION}", role: 'role-test-push') {
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

        stage('Tag Image for Docker Hub') {
            steps {
                sh '''
                echo "Tagging image for Docker Hub..."
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${DOCKER_REPO}:${DOCKER_TAG}
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASSWORD')]) {
                    sh '''
                    echo "Logging in to Docker Hub..."
                    echo "$DOCKER_PASSWORD" | docker login -u ${DOCKER_HUB_USER} --password-stdin

                    echo "Pushing Docker image to Docker Hub..."
                    docker push ${DOCKER_REPO}:${DOCKER_TAG}
                    '''
                }
            }
        }

    }
}
