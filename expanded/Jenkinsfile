pipeline 
{
    agent 
    {
        label 'docker-node'
    }
    environment
    {
        DOCKERHUB_CREDENTIALS=credentials('docker-hub')
    }
    stages
    {
        stage('Clone') 
        {
            steps 
            {
                git branch: 'main', url: 'http://192.168.150.202:3000/vagrant/exam'
            }
        }
        stage('Build the images')
        {
            steps
            {
                sh 'cd client ; docker image build -t img-client .'
                sh 'cd storage ; docker image build -t img-storage .'
                sh 'cd generator ; docker image build -t img-generator .'
            }
        }
        stage('Create Network')
        {
            steps
            {
                sh 'docker network create -d bridge exam-net || true'
            }
        }
        stage('Run')
        {
            steps
            {
                sh '''
                    docker container rm -f con-client con-storage con-generator || true
                    docker container run -d --net exam-net -p 8080:5000 --name con-client img-client
                    docker container run -d --net exam-net -e MYSQL_ROOT_PASSWORD='ExamPa$$w0rd' --name con-storage img-storage
                    docker container run -d --net exam-net --name con-generator img-generator
                    '''
            }
        }
        stage('Test Client')
        {
            steps
            {
                script 
                {
                    echo 'Test #1 - reachability'
                    sleep 60
                    sh 'echo $(curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:8080) | grep 200'
                }
            }
        }
        stage('CleanUp')
        {
            steps
            {
                sh 'docker container rm -f con-client con-storage con-generator || true'
            }
        }
        stage('Login to dockerhub') 
        {
            steps 
            {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push the images to dockerhub') 
        {
            steps 
            {
                sh 'docker image tag img-client naskodlg/img-client'
                sh 'docker push naskodlg/img-client'
                sh 'docker image tag img-storage naskodlg/img-storage'
                sh 'docker push naskodlg/img-storage'
                sh 'docker image tag img-generator naskodlg/img-generator'
                sh 'docker push naskodlg/img-generator'
            }
        }
        stage('Docker containers deployed on Prod')
        {
            steps
            {
                sh '''
                    docker container rm -f con-client con-storage con-generator || true
                    docker container run -d --net exam-net -p 80:5000 --name con-client naskodlg/img-client
                    docker container run -d --net exam-net -e MYSQL_ROOT_PASSWORD='ExamPa$$w0rd' --name con-storage naskodlg/img-storage
                    docker container run -d --net exam-net --name con-generator naskodlg/img-generator
                    '''
            }
        }
    }
}