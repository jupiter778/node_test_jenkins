pipeline {
    agent any

    environment {
        REPO_URL           = "https://github.com/jupiter778/node_test_jenkins.git"
        LOCAL_IMAGE_NAME   = "myapp"                 // ชื่อ image ตอน build ในเครื่อง
        LOCAL_TAG          = "latest"                // tag ของ local image
        DOCKER_REPO        = "cnwsb777/test-docker"    // repo บน Docker Hub
        DOCKER_TAG         = "v1"                    // tag ที่ต้องการ push
        DOCKER_HUB_USER    = "cnwsb777"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git credentialsId: 'github-token', url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Docker Build') {
            steps {
                bat """
                echo Building Docker Image...
                docker build -t ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} .
                """
            }
        }

        stage('Tag Image for Docker Hub') {
            steps {
                bat """
                echo Tagging image for Docker Hub...
                docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${DOCKER_REPO}:${DOCKER_TAG}
                """
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASSWORD')]) {
                    bat """
                    echo Logging in to Docker Hub...
                    docker login -u ${DOCKER_HUB_USER} -p %DOCKER_PASSWORD%

                    echo Pushing image to Docker Hub...
                    docker push ${DOCKER_REPO}:${DOCKER_TAG}
                    """
                }
            }
        }
    }
}
