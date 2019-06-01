# README

Per avviare il progetto installare Docker e Docker Compose.

Per lanciare la build eseguire

<code>$ docker-compose up</code>

Al primo avvio serve inizializzare il database con i comandi

<code>$ docker-compose exec web rails db:create</code>

<code>$ docker-compose exec web rails db:migrate</code>

<code>$ docker-compose exec web rails db:seed</code>
