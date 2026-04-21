pipeline{
    agent{
        node{
            label 'AGENT-1'
        }
    }
    environment{
        appVersion = ''
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
    }
}