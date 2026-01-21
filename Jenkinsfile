pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'https://github.com/your-org/your-repo.git'
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t my-app:${BUILD_NUMBER} .'
      }
    }

    stage('Test') {
      steps {
        sh 'docker run --rm my-app:${BUILD_NUMBER} npm test'
      }
    }

    stage('Deploy') {
      steps {
        sh '''
          docker stop my-app || true
          docker rm my-app || true
          docker run -d -p 8082:3000 --name my-app my-app:${BUILD_NUMBER}
        '''
      }
    }
  }
}
