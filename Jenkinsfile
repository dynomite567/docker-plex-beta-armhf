node {
    def app

    stage('Check for cloned Repo') {

        checkout scn
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