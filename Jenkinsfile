pipeline {
    agent any

    environment {
        REPO_URL           = "https://github.com/jupiter778/node_test_jenkins.git"
        LOCAL_IMAGE_NAME   = "myapp"
        LOCAL_TAG          = "latest"
        DOCKER_REPO        = "cnwsb777/test-docker"
        DOCKER_TAG         = "v1"
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

        stage('Tag Image for Docker Hub') {
            steps {
                sh '''
                echo "Tagging image for Docker Hub..."
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${DOCKER_REPO}:${DOCKER_TAG}
                '''
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASSWORD')]) {
                    sh '''
                    echo "Logging in to Docker Hub..."
                    echo "$DOCKER_PASSWORD" | docker login -u ${DOCKER_HUB_USER} --password-stdin

                    echo "Pushing image to Docker Hub..."
                    docker push ${DOCKER_REPO}:${DOCKER_TAG}
                    '''
                }
            }
        }
    }
}
