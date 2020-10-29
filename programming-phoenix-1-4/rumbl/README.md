# Rumbl

## Notes

- [mix tasks](./mix.md)

- iex in context of mix script (access to modules): 
<pre>
iex -S mix
</pre>

- recompile/reload modules in iex:
<pre>
iex > c "lib/rumbl/accounts.ex"
iex > r Accounts
iex > recompile()
</pre>

- add video by hand, test context
```iex
{:ok, video} = Rumbl.Multimedia.create_video %{
    title: "1965 Francis Bacon - Lost Interview With Francis Bacon",
    url: "https://www.youtube.com/watch?v=GbYstSBSB_U",
    description: "Francis Bacon at the BBC | The artist discusses his paintings and influences"
}
```