pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                sh 'ls -R .'
            }
        }

        stage('Start Databases') {
            steps {
                sh '''
                    echo "Starting MySQL + Postgres..."
                    docker compose up -d mysql_source postgres_dest

                    echo "Waiting for MySQL to be healthy..."
                    until [ "$(docker inspect -f {{.State.Health.Status}} mysql_source)" = "healthy" ]; do
                        echo "MySQL not ready yet..."
                        sleep 3
                    done

                    echo "Waiting for Postgres to start..."
                    until docker exec postgres_dest pg_isready > /dev/null 2>&1; do
                        echo "Postgres not ready yet..."
                        sleep 3
                    done

                    echo "Databases are ready."
                '''
            }
        }

        stage('Run ETL') {
            steps {
                sh '''
                    echo "Running ETL..."
                    docker compose run --rm etl
                '''
            }
        }

        stage('Run dbt Transformations') {
            steps {
                sh '''
                    echo "Running dbt run..."
                    docker compose run --rm dbt run
                '''
            }
        }

        stage('Run dbt Tests') {
            steps {
                sh '''
                    echo "Running dbt tests..."
                    docker compose run --rm dbt test
                '''
            }
        }


    }
}
