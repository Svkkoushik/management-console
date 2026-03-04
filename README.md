# management-console


## General information

This repository is a [monorepo](https://en.wikipedia.org/wiki/Monorepo) using `pnpm` and [`turborepo`](https://turbo.build/repo/docs).

It is roughly divided into two parts:

- `apps/*` - the folder containing applications, i.e. our NextJS webapp
- `services/*` - the folder containing our services, i.e. the ingestion service

The applications are written in TypeScript and the services in Python. 

## Initial setup

This repository requires the following tools for development:

- nodejs 
- pnpm ([Installation instructions](https://pnpm.io/installation#using-npm))
- python
- rye ([Installation instructions](https://rye.astral.sh/guide/installation/))
- docker / docker-compose

Assuming the tools above are installed, run the following commands in the root of the project

``` shell
pnpm install
pnpm initial-setup
```

This should install all required dependencies for both the webapp as well as the python services.


## Development

### Database management

The python backend "owns" the database, i.e. it is responsible for managing the database schema and performing migrations.

We are using [TortoiseORM](https://tortoise.github.io/getting_started.html) as an ORM as well as its tool [Aerich](https://github.com/tortoise/aerich) to automatically generate migrations and for running them.

The database models are located in `database/models.py`, and when doing anything with the models(modifying existing models, adding new ones, deleting models, etc) a migration needs to be generated.

After making changes to the models, run `rye run aerich migrate --name <migration_name>` - please try to use informative names for the migrations, such as `add_foo_model` or `change_column_type`, etc.
After generating a migration, it also needs to be applied, which you do by running `rye run aerich upgrade` - this automatically applies all migrations that haven't head been applied. 

If you are iterating on changes to the database and you made a mistake and need to roll back a migration, you can run `rye run aerich downgrade` - it will prompt you because this can be dangerous. You can then make the changes you need to make to the models, and run `rye run aerich migrate --name <migration_name>` again.

**IMPORTANT:** Not all migrations that will be generated are automatically safe. Always review migrations to ensure that they are doing the appropriate thing and modify them manually if needed.

### To run everything at once

Everything(webapp, services and postgres + rabbitmq in docker) can be started with a single command:

``` shell
pnpm dev
```

This should: 

1. Start postgres, rabbitmq via docker compose
2. Start the webapp
3. Start the ingestion service

The webapp can now be visited at `http://localhost:3000`, and the ingestion-service at `http://localhost:8080/docs`

Hot-reloading is enabled during development, i.e. there is no need to restart this process every time a change in made in neither the python or typescript projects.


### To run only the ingestion service

Run

``` shell
pnpm dev:ingestion
```



### To only run the webapp

Run

```shell
pnpm dev:webapp
```

### Usage in VS Code

There is also VS Code configuration. It is possible to run initial setup via tasks (ctrl+shift+p > run task > initial setup).

To run the ingestion service, open the `Run and Debug` pane(ctrl+shift+d) and choose `Launch ingestion service` and run it(or press F5).


### Python development information

The root of the python ingestion service is `services/ingestion`, and it contains all the project related configuration as well as the code.
