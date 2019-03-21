docker build -t framegenerator/multi-client:latest -t framegenerator/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t framegenerator/multi-server:latest -t framegenerator/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t framegenerator/multi-worker:latest -t framegenerator/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push framegenerator/multi-client:latest
docker push framegenerator/multi-server:latest
docker push framegenerator/multi-worker:latest
docker push framegenerator/multi-client:$SHA
docker push framegenerator/multi-server:$SHA
docker push framegenerator/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=framegenerator/multi-server:$SHA
kubectl set image deployments/client-deployment client=framegenerator/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=framegenerator/multi-worker:$SHA

