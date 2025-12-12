pipeline {
    agent any

    environment {
        REPO_URL     = "https://github.com/jupiter778/node_test_jenkins.git"
        REGISTRY_URL = "docker.io"
        IMAGE_NAME   = "cnwsb777/test_docker"
        DOCKER_HUB_USERNAME = "cnwsb777"
        dockerImage  = "${REGISTRY_URL}/${IMAGE_NAME}:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'github-token', url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Docker Build Release') {
            steps {
               bat """
               docker build ^
                -t ${dockerImage} ^
                .
               """
            }
        }

        stage('Docker Push') {
            steps {
                echo '--------- Docker Push ---------'
                withCredentials([string(credentialsId: '', variable: 'DOCKER_PASSWORD')]) {
                    bat """
                    docker login -u ${DOCKER_HUB_USERNAME} -p %DOCKER_PASSWORD%
                    docker push ${dockerImage}
                    """
                }
            }
        }
    }
}
