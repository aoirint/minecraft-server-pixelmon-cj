include .env

MESSAGE=テストメッセージ
PLAYER_ID=

.PHONY: backup-all
backup-all:
	zip -r "backups/data_$(shell date '+%Y-%m-%d_%H-%M-%S').zip" "./data"

.PHONY: backup-world
backup-world:
	zip -r "backups/data_world_$(shell date '+%Y-%m-%d_%H-%M-%S').zip" "./data/FeedTheBeast/serverpack/world"

.PHONY: save-all
save-all:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	echo "/save-all" > /proc/$(PID)/fd/0

.PHONY: get-pid
get-pid:
	@echo $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }')

.PHONY: say
say:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	@echo "/say $(MESSAGE)" > /proc/$(PID)/fd/0

.PHONY: list
list:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	@echo "/list" > /proc/$(PID)/fd/0
	@docker compose logs --no-log-prefix --tail=20 minecraft | tac | grep -Pzo '(.*)\n(.*)There are .*/.* players online:' | head -n1 | sed 's/.*\[minecraft\/DedicatedServer\]:\s*\(.*\)/\1/'

.PHONY: whitelist-add
whitelist-add:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	echo "/whitelist add $(PLAYER_ID)" > /proc/$(PID)/fd/0

.PHONY: whitelist-remove
whitelist-remove:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	echo "/whitelist remove $(PLAYER_ID)" > /proc/$(PID)/fd/0

.PHONY: whitelist-reload
whitelist-reload:
	@$(eval PID := $(shell docker compose top | grep 'java -server' | awk '{ print $$2 }'))
	echo "/whitelist reload" > /proc/$(PID)/fd/0

.PHONY: players-online
players-online:
	@docker run --rm --network host --entrypoint "" aoirint/mcstatus:20220818.1 gosu user python3 -c 'from mcstatus import JavaServer; print(JavaServer.lookup("127.0.0.1:25575").status().players.online)'

.PHONY: dump-logs
dump-logs:
	docker compose logs -t > logs/$(shell date '+%Y-%m-%d_%H-%M-%S').log

