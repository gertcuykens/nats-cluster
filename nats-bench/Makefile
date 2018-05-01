build:
	env GOOS=linux go build
	docker build -t gertcuykens/nats:bench .
	docker push gertcuykens/nats:bench

run: CMD=-tls /tls bench-subject
run:
# docker pull gertcuykens/nats:bench-nats
	docker run --rm -v $(PWD)/../tls:/tls gertcuykens/nats:bench $(CMD)

test:
# gnatsd -config ../nats.conf -D
	go run main.go -tls ../tls bench-subject

kube:
	-kubectl delete -f nats-bench.yaml
	kubectl apply -f nats-bench.yaml
# kubectl logs -f nats-bench...

.PHONY: tls
