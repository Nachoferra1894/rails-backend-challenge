run:
	docker compose run --no-deps web rails new . --force --database=postgresql
dev:
	docker compose up
setup:
	docker compose build
down:
	docker compose down
migratetest:
	rails db:migrate RAILS_ENV=test
coverage:
	COVERAGE=true rake test
seecoverage:
	open coverage/index.html
test:
	rake test


.PHONY: run dev setup down migratetest coverage test