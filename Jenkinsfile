pipeline {
    agent any

    tools {
        nodejs 'NodeJS' // Name of the Node.js configuration in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install npm dependencies
                bat 'npm install'
            }
        }

        stage('Build') {
            steps {
                // Build the React application
                bat 'npm run build'
            }
        }

        // stage('Test') {
        //     steps {
        //         // Run unit tests
        //         bat 'npm test -- --watchAll=false'
        //     }
        // }
    }

    post {
        success {
            echo 'Build and test successful!'
        }
        failure {
            echo 'Build or test failed!'
        }
        always {
            // Clean workspace after the pipeline run
            cleanWs()
        }
    }
}
