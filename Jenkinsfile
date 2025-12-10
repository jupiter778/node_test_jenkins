pipeline {
    agent any

    environment {
        REPO_URL     = "https://github.com/username/repo.git"
        REGISTRY_URL = ""
        IMAGE_NAME   = ""
        GITHUB_USERNAME = ""
        dockerImage  = "${REGISTRY_URL}/${IMAGE_NAME}:latest"

    }

    stages {
        stage('Checkout Code') {
            steps {
                git credentialsId: 'admin_gitea', url: "${REPO_URL}", branch: 'main'
            }
        }

        stage('Docker Build Release') {
            steps {
               sh """
               docker build \
                -t ${dockerImage} \
                -f services/nest-service/Dockerfile \
                .
                """
            }
        }

        stage('Docker Push') {
            steps {
                echo '------------------------------------------------------------------------------------------------------------'
                withCredentials([string(credentialsId: 'TakawatP', variable: 'GITHUB_TOKEN')]) {
                    sh """
                    echo "\$GITHUB_TOKEN" | docker login ${REGISTRY_URL} -u ${GITHUB_USERNAME} --password-stdin
                    docker push ${dockerImage}
                    """
                }
            }
        }
    }
}
///