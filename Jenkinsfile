node {
    stage ('Clone Repo') {
        checkout scm
    }
    stage('Build Image') {
        app = docker.build("dynomitecentral/plex-beta-armhf")
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Test Success"'
        }
    }

    stage('Push Image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("weekly")
        }
    }
} 

