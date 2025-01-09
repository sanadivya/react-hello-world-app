pipeline {
    agent any

    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Git branch to build')

    }

    tools {
        nodejs 'NODEJS' // Name of the Node.js configuration in Jenkins
    }

    stages {
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

        stage('Test') {
            steps {
                // Run unit tests
                bat 'npm test -- --watchAll=false'
            }
        }

        stage('Install Vercel CLI') {
            steps {
                bat 'npm install -g vercel' // Installs Vercel CLI
            }
        }

        stage('Deploy to Vercel') {
            steps {
                withCredentials([string(credentialsId: 'VERCEL_TOKEN', variable: 'MY_VERCEL_TOKEN')]) {
                    bat 'npx vercel --prod --token %MY_VERCEL_TOKEN% --yes --name react-hello-world-app'
                //bat 'vercel deploy --prod --token %VERCEL_TOKEN%'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and test successful!'
            emailext(
                to: 'sanadivya06@gmail.com',
                subject: "Jenkins Job '${env.JOB_NAME}' Build #${env.BUILD_NUMBER} Success",
                body: """<p>Good news! The Jenkins build was successful.</p>
                        <p>Job: ${env.JOB_NAME}<br>Build: #${env.BUILD_NUMBER}</p>
                        <p><a href="${env.BUILD_URL}">Click here to view the build details.</a></p>""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
        failure {
            echo 'Build or test failed!'
            emailext(
                to: 'sanadivya06@gmail.com',
                subject: "Jenkins Job '${env.JOB_NAME}' Build #${env.BUILD_NUMBER} Failed",
                body: """<p>Unfortunately, the Jenkins build has failed.</p>
                        <p>Job: ${env.JOB_NAME}<br>Build: #${env.BUILD_NUMBER}</p>
                        <p><a href="${env.BUILD_URL}">Click here to view the build details.</a></p>"""
            )
        }
        always {
            // Clean workspace after the pipeline run
            cleanWs()
        }
    }
}
