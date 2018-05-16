node("dockerarmhf") {
    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
    
        git url: "https://github.com/dynomite567/docker-plex-beta-armhf.git", credentialsId: 'GitHub'
    
        sh "git rev-parse HEAD > .git/commit-id"
        def commit_id = readFile('.git/commit-id').trim()
        println commit_id
    
        stage "Build image"
        def app = docker.build "dynomitecentral/plex-beta-armhf"
    
        stage "Publish image"
        app.push "${env.BUILD_NUMBER}"
        app.push 'latest'
    }
}
