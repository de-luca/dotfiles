function drun() {
	docker-compose run --rm --entrypoint $2 $1
}

function dstats() {
	docker stats --format "table {{.Name}}\t{{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
}
