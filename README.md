# Assignment #1: Containers with Docker

>
> **Name:** Arham Hussain Inamdar

> **Student ID:** 801404110

> **Email:** ainamda3@charlotte.edu

A two-container stack: a PostgreSQL database seeded from `db/init.sql`, and a Python app
that queries it, computes a few statistics, prints them, and writes `out/summary.json`.

## Implementation

The Python app reads its database connection settings from environment
variables supplied by Docker Compose. It queries the total number of trips,
the average fare per city rounded to two decimal places, and the longest
trips ordered by duration, with ties broken alphabetically by city.

The app prints the results as JSON and saves them to out/summary.json.
Docker Compose waits for the database healthcheck before starting the app,
and the app retries failed database connections.

## Repository layout

```
.
├─ app/           main.py, Dockerfile
├─ db/            init.sql, Dockerfile
├─ out/           summary.json (created at run time)
├─ compose.yml
├─ Makefile
├─ .gitignore
└─ README.md
```

## How to run and stop

Start Docker Desktop and wait for its engine to be running. From the
project folder, build and start the stack:

```powershell
docker compose up --build
```

The app prints its summary and exits. The database continues running.
In another terminal, or after pressing Ctrl+C, stop and remove the containers:

```powershell
docker compose down
```

To view the saved output in PowerShell:

```powershell
Get-Content .\out\summary.json
```

The included Makefile also provides `make` and `make down` for environments
with Make and a Unix-compatible shell.

## Example output

```json
{
  "total_trips": 12,
  "avg_fare_by_city": [
    {
      "city": "Atlanta",
      "avg_fare": 21.75
    },
    {
      "city": "Charlotte",
      "avg_fare": 16.25
    },
    {
      "city": "Dubai",
      "avg_fare": 33.75
    },
    {
      "city": "Lisbon",
      "avg_fare": 14.0
    },
    {
      "city": "London",
      "avg_fare": 38.0
    },
    {
      "city": "New York",
      "avg_fare": 19.0
    },
    {
      "city": "San Francisco",
      "avg_fare": 20.25
    }
  ],
  "top_by_minutes": [
    {
      "city": "Dubai",
      "minutes": 35,
      "fare": 42.0
    },
    {
      "city": "London",
      "minutes": 35,
      "fare": 38.0
    },
    {
      "city": "Atlanta",
      "minutes": 28,
      "fare": 26.0
    },
    {
      "city": "San Francisco",
      "minutes": 28,
      "fare": 29.3
    },
    {
      "city": "New York",
      "minutes": 26,
      "fare": 27.1
    },
    {
      "city": "Dubai",
      "minutes": 22,
      "fare": 25.5
    },
    {
      "city": "Charlotte",
      "minutes": 21,
      "fare": 20.0
    },
    {
      "city": "Atlanta",
      "minutes": 18,
      "fare": 17.5
    },
    {
      "city": "Lisbon",
      "minutes": 16,
      "fare": 14.0
    },
    {
      "city": "Charlotte",
      "minutes": 12,
      "fare": 12.5
    }
  ]
}
```

## Where outputs are written

`out/summary.json`, which is bind-mounted from the `app` container's `/out`.

## Troubleshooting

- **The app exits before the database is ready.** `compose.yml` already waits on the db
  healthcheck, and `main.py` retries. If it still fails, check the credentials match
  between the two services.
- **Permission errors on `out/`.** On Linux the bind-mounted directory may end up owned by
  root. `sudo chown -R $USER out` fixes it; `make clean` recreates the directory.
- **Stale database.** The seed script in `db/init.sql` runs only on first initialisation.
  Run `make down` (which passes `-v` and drops the volume) before starting again.
- **Docker engine connection error:** Open Docker Desktop and wait for the
  engine to start, then rerun `docker compose up --build`.

## Notes on credentials

The database user and password here are throwaway values used only on your machine, so
committing them is fine for this assignment. Real credentials belong in a `.env` file that
is listed in `.gitignore`.
