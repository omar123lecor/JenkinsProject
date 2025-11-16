pipeline {
    agent any

    environment {
        MYSQL_SERVICE = "mysql"
        POSTGRES_SERVICE = "postgres"
        SQL_FILE = "/var/jenkins_home/workspace/pipi/mysql/file.sql"
    }

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
                    echo "Starting MySQL and Postgres..."
                    docker compose up -d mysql postgres

                    echo "Waiting for MySQL to be ready..."
                    until [ "$(docker inspect -f {{.State.Health.Status}} $(docker compose ps -q $MYSQL_SERVICE))" = "healthy" ]; do
                        echo "MySQL not ready yet..."
                        sleep 3
                    done

                    echo "Waiting for Postgres to be ready..."
                    until docker exec $(docker compose ps -q $POSTGRES_SERVICE) pg_isready > /dev/null 2>&1; do
                        echo "Postgres not ready yet..."
                        sleep 3
                    done

                    echo "Databases are ready!"
                '''
            }
        }

        stage('Init MySQL DB') {
            steps {
                sh '''
                    MYSQL_CONTAINER=$(docker compose ps -q $MYSQL_SERVICE)
                    docker cp /var/jenkins_home/workspace/pipi/mysql/file.sql $MYSQL_CONTAINER:/tmp/file.sql
                    docker exec $MYSQL_CONTAINER sh -c "mysql -uroot -proot sales_db < /tmp/file.sql"
                '''
            }
        }

        stage('Run ETL') {
            steps {
                sh 'docker compose run --rm etl'
            }
        }
        stage('Run dbt Transformations') {
            steps {
                sh '''
                    DBT_CONTAINER=$(docker compose run -d dbt)
                    docker cp dbt/target/dbt_project.yml $DBT_CONTAINER:/usr/app/dbt/dbt_project.yml
                    docker cp dbt/target/profiles.yml $DBT_CONTAINER:/usr/app/dbt/profiles.yml
                    docker cp dbt/target/models $DBT_CONTAINER:/usr/app/dbt/models
                    docker exec $DBT_CONTAINER dbt run --rm

                '''
            }
        }

        stage('Run dbt Tests') {
            steps {
                sh 'docker compose run --rm -v $WORKSPACE/dbt:/usr/app/dbt dbt test'
            }
        }


    }
}
