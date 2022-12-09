docker build -t barisozcanli/multi-client:latest -t barisozcanli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t barisozcanli/multi-server:latest -t barisozcanli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t barisozcanli/multi-worker:latest -t barisozcanli/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push barisozcanli/multi-client:latest
docker push barisozcanli/multi-server:latest
docker push barisozcanli/multi-worker:latest

docker push barisozcanli/multi-client:$SHA
docker push barisozcnali/multi-server:$SHA
docker push barisozcanli/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=barisozcanli/multi-server:$SHA
kubectl set image deployments/client-deployment client=barisozcanli/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=barisozcanli/multi-worker:$SHA