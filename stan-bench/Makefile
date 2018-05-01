build:
	env GOOS=linux go build
	docker build -t gertcuykens/nats:stan-bench .
	docker push gertcuykens/nats:stan-bench

run: CMD=-tls /tls bench-subject
run:
	docker run --rm -v $(PWD)/../tls:/tls gertcuykens/nats:stan-bench $(CMD)

test:
# gnatsd -config ../nats.conf -D
	go run main.go -s=nats://nats_client_user:nats_client_pwd@nats:4222 -tls=../tls bench-subject

kube:
	-kubectl delete -f stan-bench.yaml
	kubectl apply -f stan-bench.yaml
# kubectl logs -f stan-bench-...
