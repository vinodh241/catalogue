pipeline{
    agent{
        node{
            label 'AGENT-1'
        }
    }
    environment{
        appVersion = ''
        REGION = 'us-east-1'
        ACCOUNT_ID = '804838453201'
        PROJECT = 'roboshop'
        COMPONENT = 'catalogue'
    }
    stages {
        stage('Read Package.json'){
            steps{
                script {
                    // Read the file from the workspace
                    def packageJSON = readJSON file: 'package.json' 
                    // Access specific fields
                    appVersion = packageJSON.version
                    echo "Package version :${appVersion}"
                }
            }
        }
        stage('Install Dependencies'){
            steps{
                script {
                    sh """
                        npm install 
                    """
                }
            }
        }
        stage('Docker Build'){
            steps{
                script {
                    withAWS(credentials: 'aws-cred', region: 'us-east-1') {
                        sh """
                             aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
                             docker build -t  ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                             docker push  ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                           """
                    }
                }
            }
        }
    }
}