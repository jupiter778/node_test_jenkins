pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/jupiter778/node_test_jenkins.git"

        LOCAL_IMAGE_NAME = "myapp"
        LOCAL_TAG        = "latest"

        GHCR_USER  = "jupiter778"
        GHCR_REPO  = "node_test_jenkins"
        GHCR_IMAGE = "ghcr.io/${GHCR_USER}/${GHCR_REPO}:${LOCAL_TAG}"

        ECS_CLUSTER = "lovable-shark-jxuzst"
        ECS_SERVICE = "node-test-service"
        AWS_DEFAULT_REGION = "ap-southeast-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git credentialsId: 'token-github-classic',
                    url: REPO_URL,
                    branch: 'main'
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

        stage('Tag Image') {
            steps {
                sh '''
                    docker tag ${LOCAL_IMAGE_NAME}:${LOCAL_TAG} ${GHCR_IMAGE}
                '''
            }
        }

        stage('Login to GHCR') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'credentials-jenkins',
                        usernameVariable: 'GH_USER',
                        passwordVariable: 'GH_TOKEN'
                    )
                ]) {
                    sh '''
                        echo "$GH_TOKEN" | docker login ghcr.io -u "$GH_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push to GHCR') {
            steps {
                sh '''
                    docker push ${GHCR_IMAGE}
                '''
            }
        }

        stage('Deploy to Kubernetes') {
    steps {
        sh '''
          echo "Deploying to Kubernetes..."
          kubectl apply -f k8s/deployment.yaml
        '''
    }
}
    }
}
