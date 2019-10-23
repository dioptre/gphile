#!/bin/bash
sh -c '/usr/local/bin/postgraphile -c "postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB?ssl=$POSTGRES_SSL" --enhance-graphiql'