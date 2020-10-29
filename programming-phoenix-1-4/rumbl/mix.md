# mix tasks

- create migration script
```console
mix ecto.gen.migration create_users
```

- migrate, reset, rollback:

```console
mix ecto.migrate
mix ecto.reset
mix ecto.rollback
```

- phx.gen.html

```console
mix phx.gen.html Multimedia Video videos user_id:references:users url:string title:string description:text
```