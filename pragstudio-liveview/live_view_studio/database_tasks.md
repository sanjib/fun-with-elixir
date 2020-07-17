# Database Tasks

```console
mix phx.gen.context KinokuniyaStores KinokuniyaStore kinokuniya_stores address1:string, address2:string, city:string, state:string, zip:string, country:string, phone:string, opening_hours:string
mix ecto.migrate
mix ecto.reset
```