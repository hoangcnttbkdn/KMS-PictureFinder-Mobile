pipeline {
    agent any
    stages {
        stage('Prepare workspace') {
            steps {
                echo 'Prepare workspace'
                step([$class: 'WsCleanup'])
                script {
                    def commit = checkout scm
                    env.BRANCH_NAME = commit.GIT_BRANCH.replace('origin/', '')
                }
            }
        }

        stage('Build APK') {
            steps {
                sh "flutter build apk"
            }
        }

        stage('Publish for Development') {
            when {
                expression {
                    return (env.BRANCH_NAME == 'develop')
                }
            }
            steps {
                appCenter apiToken: "${API_TOKEN}", 
                    appName: 'PicturesFinder', 
                    distributionGroups: 'Development', 
                    ownerName: 'hoangsndxqn-gmail.com', 
                    pathToApp: "build/app/outputs/flutter-apk/app-release.apk"
            }
        }

        stage('Publish for Production') {
            when {
                expression {
                    return (env.BRANCH_NAME == "refs/tags/${GIT_BRANCH.tokenize('/').pop()}")
                }
            }
            steps {
                appCenter apiToken: "${API_TOKEN}", 
                    appName: 'PicturesFinder', 
                    distributionGroups: 'Production', 
                    ownerName: 'hoangsndxqn-gmail.com', 
                    pathToApp: "build/app/outputs/flutter-apk/app-release.apk"
            }
        }
    }

    post {
        success {
            echo "SUCCESSFUL"
        }
        failure {
            echo "FAILED"
        }
    }
}
