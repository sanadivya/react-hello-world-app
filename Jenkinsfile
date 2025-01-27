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

        stage('Archive Build'){
            steps{
                archiveArtifacts artifacts: 'build/**', followSymlinks: false
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
        
        // stage('Build Images'){
        //     steps{
        //         bat 'docker build -t react-hello-world-app .'
        //     }
        // }

        // stage('Push images to DockerHub'){
        //     steps{
        //         withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
        //         bat 'docker build -t react-hello-world-app .'
        //     //    bat "docker tag react-hello-world-app %DOCKER_USERNAME%/react-hello-world-app"
        //     //    bat "docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%" // Login to Docker Hub
        //     //    bat "docker push %DOCKER_USERNAME%/react-hello-world-app"
        //         }
        //     }
        // }
    }
}

post {
    success {
        echo 'Build and test successful!'
        emailext(
            //to: 'sanadivya06@gmail.com',
            subject: "Jenkins Job '${env.JOB_NAME}' Build #${env.BUILD_NUMBER} Success",
            body: """
            <html>
            <body>
            <h2>Good news! The Jenkins build was successful.</h2>
                    <h4>Job: ${env.JOB_NAME}<br>Build: #${env.BUILD_NUMBER}</h4>
                    <h4><a href="${env.BUILD_URL}">Click here to view the build details.</a></h4>
            </body>
            </html>
            """,
            to: '$DEFAULT_RECIPIENTS',
            attachLog: true
            //recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
    }
    failure {
        echo 'Build or test failed!'
        emailext(
            //to: 'sanadivya06@gmail.com',
            subject: "Jenkins Job '${env.JOB_NAME}' Build #${env.BUILD_NUMBER} Failed",
            body: """
            <html>
            <body>
            <h2>Unfortunately, the Jenkins build has failed.</h2>
                    <h4>Job: ${env.JOB_NAME}<br>Build: #${env.BUILD_NUMBER}</h4>
                    <h4><a href="${env.BUILD_URL}">Click here to view the build details.</a></h4>
            </body>
            </html>
            """,
            to: '$DEFAULT_RECIPIENTS',
            attachLog: true
        )
    }
    always {
        // Clean workspace after the pipeline run
        cleanWs()
    }
}
    

