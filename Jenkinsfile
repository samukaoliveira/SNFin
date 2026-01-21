pipeline {
  agent any

  triggers {
    githubPush()
  }

  environment {
    GITHUB_OWNER = "samukaoliveira"
    GITHUB_REPO  = "SNFin"
    GITHUB_REF   = "master"
    WORKFLOW_YML = "ci.yml"
    POLL_DELAY   = 20
    MAX_TRIES    = 30
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Disparar GitHub Actions') {
      steps {
        withCredentials([string(credentialsId: 'github-actions-token', variable: 'GITHUB_TOKEN')]) {
          sh '''
            set -e

            COMMIT_SHA=$(git rev-parse HEAD)
            echo "🚀 Disparando GitHub Actions"
            echo "Commit: $COMMIT_SHA"

            curl -s -X POST \
              -H "Authorization: Bearer $GITHUB_TOKEN" \
              -H "Accept: application/vnd.github+json" \
              https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/actions/workflows/$WORKFLOW_YML/dispatches \
              -d "{\"ref\":\"$GITHUB_REF\"}"
          '''
        }
      }
    }

    stage('Aguardar GitHub Actions') {
      steps {
        withCredentials([string(credentialsId: 'github-actions-token', variable: 'GITHUB_TOKEN')]) {
          sh '''
            set -e

            COMMIT_SHA=$(git rev-parse HEAD)
            echo "⏳ Aguardando GitHub Actions do commit $COMMIT_SHA"

            ATTEMPT=1

            while [ $ATTEMPT -le $MAX_TRIES ]; do
              echo "🔁 Tentativa $ATTEMPT/$MAX_TRIES"

              RESPONSE=$(curl -s \
                -H "Authorization: Bearer $GITHUB_TOKEN" \
                -H "Accept: application/vnd.github+json" \
                "https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/actions/runs?event=workflow_dispatch&branch=$GITHUB_REF")

              RUN_ID=$(echo "$RESPONSE" | jq -r --arg SHA "$COMMIT_SHA" '
                .workflow_runs
                | map(select(.head_sha == $SHA))
                | sort_by(.created_at)
                | last
                | .id
              ')

              if [ "$RUN_ID" = "null" ] || [ -z "$RUN_ID" ]; then
                echo "⚠️ Workflow ainda não iniciou"
                sleep $POLL_DELAY
                ATTEMPT=$((ATTEMPT+1))
                continue
              fi

              RUN=$(curl -s \
                -H "Authorization: Bearer $GITHUB_TOKEN" \
                -H "Accept: application/vnd.github+json" \
                https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/actions/runs/$RUN_ID)

              STATUS=$(echo "$RUN" | jq -r '.status')
              CONCLUSION=$(echo "$RUN" | jq -r '.conclusion')

              echo "📊 Status: $STATUS | Conclusão: $CONCLUSION"

              if [ "$STATUS" = "completed" ]; then
                if [ "$CONCLUSION" = "success" ]; then
                  echo "✅ GitHub Actions finalizou com sucesso"
                  exit 0
                else
                  echo "❌ GitHub Actions falhou: $CONCLUSION"
                  exit 1
                fi
              fi

              sleep $POLL_DELAY
              ATTEMPT=$((ATTEMPT+1))
            done

            echo "❌ Timeout aguardando GitHub Actions"
            exit 1
          '''
        }
      }
    }

    stage('Build / Deploy') {
      steps {
        echo "🚀 Build autorizado — GitHub Actions OK"
        // deploy, docker, kubernetes, etc
      }
    }
  }

  post {
    success {
      echo "✅ Pipeline finalizada com sucesso"
    }
    failure {
      echo "❌ Pipeline falhou"
    }
  }
}
