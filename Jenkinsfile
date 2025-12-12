pipeline {
    agent any

    environment {
        REPO_URL     = "https://github.com/jupiter778/node_test_jenkins.git"
        REGISTRY_URL = "docker.io"
        IMAGE_NAME   = "cnwsb777/test_docker"
        GITHUB_USERNAME = "jupiter778"
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
        echo '----------------------------------------'
        withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_PASSWORD')]) {
            bat """
            echo %DOCKER_PASSWORD% | docker login docker.io -u ${GITHUB_USERNAME} --password-stdin
            docker push ${dockerImage}
            """
        }
    }
        }
    }
}
