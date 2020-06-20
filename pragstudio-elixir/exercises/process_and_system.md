# Process & System

Listing process:

```console
iex> Process.list
[#PID<0.0.0>, #PID<0.1.0>, #PID<0.2.0>, #PID<0.3.0>, #PID<0.4.0>, #PID<0.5.0>,
 #PID<0.6.0>, #PID<0.9.0>, #PID<0.41.0>, #PID<0.43.0>, #PID<0.45.0>,
 #PID<0.46.0>, #PID<0.48.0>, #PID<0.49.0>, #PID<0.50.0>, #PID<0.51.0>,
 #PID<0.52.0>, #PID<0.53.0>, #PID<0.54.0>, #PID<0.55.0>, #PID<0.56.0>,
 #PID<0.57.0>, #PID<0.58.0>, #PID<0.59.0>, #PID<0.60.0>, #PID<0.61.0>,
 #PID<0.62.0>, #PID<0.63.0>, #PID<0.64.0>, #PID<0.65.0>, #PID<0.66.0>,
 #PID<0.67.0>, #PID<0.68.0>, #PID<0.69.0>, #PID<0.76.0>, #PID<0.79.0>,
 #PID<0.80.0>, #PID<0.81.0>, #PID<0.82.0>, #PID<0.83.0>, #PID<0.85.0>,
 #PID<0.86.0>, #PID<0.87.0>, #PID<0.88.0>, #PID<0.89.0>, #PID<0.90.0>,
 #PID<0.93.0>, #PID<0.94.0>, #PID<0.95.0>, #PID<0.96.0>, ...]
iex> IO.puts "#{inspect self()}"
#PID<0.103.0>
:ok
```

Counting process:

```console
iex> Process.list |> Enum.count
54
iex> :erlang.system_info(:process_count)
54
iex> :erlang.system_info(:process_limit)
262144
```

Sending message to process:

```console
iex> parent = self()
#PID<0.178.0>
iex> pid1 = spawn(fn -> send(parent, {:result, "some message foo 1"}) end)                
#PID<0.10542.1>
iex> Process.info(parent, :messages)
{:messages, [result: "some message foo 1"]}
iex> receive do
...> {:result, msg} -> msg
...> end
"some message foo 1"
iex> Process.info(parent, :messages)
{:messages, []}
```

Flush:

```console
iex> parent = self()
#PID<0.178.0>
iex> spawn(fn -> send(parent, "yes") end)
#PID<0.26733.5>
iex> spawn(fn -> send(parent, "no") end) 
#PID<0.26904.5>
iex> spawn(fn -> send(parent, "maybe") end)
#PID<0.27107.5>
iex> Process.info(parent, :messages)
{:messages, ["yes", "no", "maybe"]}
iex> flush
"yes"
"no"
"maybe"
:ok
iex> Process.info(parent, :messages)
{:messages, []}
iex> flush                          
:ok
```

Finding a registered process:

```console
iex> Servy.PledgeServer.start
Starting the pledge server...
#PID<0.17535.0>
iex> Process.whereis(Servy.PledgeServer)
#PID<0.17535.0>
iex> Process.unregister(Servy.PledgeServer)
true
iex> Process.whereis(Servy.PledgeServer)   
nil
iex> Process.registered
[:logger_handler_watcher, :user, :elixir_code_server, :standard_error, :rex,
 IEx.Supervisor, :kernel_refc, :kernel_sup, :httpd_sup, :global_name_server,
 :code_server, :ssl_connection_sup, :erl_prim_loader, :file_server_2,
 :ssl_admin_sup, Servy.PledgeServer, :ssl_sup, :application_controller,
 :httpc_hex, Logger.Supervisor, :inet_db, :ssl_pem_cache,
 Logger.BackendSupervisor, :hackney_sup, :ssl_manager, Hex.UpdateChecker,
 Hex.Registry.Server, :observer, :wxe_master, Hex.Server, Hex.State,
 Mix.ProjectStack, :kernel_safe_sup, :global_group, Mix.TasksServer,
 :ssl_listen_tracker_sup, IEx.Broker, Mix.Supervisor, :hackney_manager,
 :erts_code_purger, :user_drv, :erl_signal_server, :init, :httpc_sup,
 :standard_error_sup, Logger, IEx.Config, :httpc_profile_sup, :httpc_manager,
 :hackney_connections, ...]
```

Check message queue length

```console
iex> pid = Servy.PledgeServer.start
Starting the pledge server...
#PID<0.240.0>
iex> 1..500 |> Enum.each(fn(n) -> send pid, {:stop, "hammertime #{n}"} end)
:ok
iex> for n <- 501..1000, do: send pid, {:stop, "hammertime #{n}"}
[
  stop: "hammertime 501",
  stop: "hammertime 502",
  stop: "hammertime 503",
  stop: "hammertime 504",
  stop: "hammertime 505",
  stop: "hammertime 506",
  stop: "hammertime 507",
  stop: "hammertime 508",
  stop: "hammertime 509",
  stop: "hammertime 510",
  stop: "hammertime 511",
  stop: "hammertime 512",
  stop: "hammertime 513",
  stop: "hammertime 514",
  stop: "hammertime 515",
  stop: "hammertime 516",
  stop: "hammertime 517",
  stop: "hammertime 518",
  stop: "hammertime 519",
  stop: "hammertime 520",
  stop: "hammertime 521",
  stop: "hammertime 522",
  stop: "hammertime 523",
  stop: "hammertime 524",
  stop: "hammertime 525",
  stop: "hammertime 526",
  stop: "hammertime 527",
  stop: "hammertime 528",
  stop: "hammertime 529",
  stop: "hammertime 530",
  stop: "hammertime 531",
  stop: "hammertime 532",
  stop: "hammertime 533",
  stop: "hammertime 534",
  stop: "hammertime 535",
  stop: "hammertime 536",
  stop: "hammertime 537",
  stop: "hammertime 538",
  stop: "hammertime 539",
  stop: "hammertime 540",
  stop: "hammertime 541",
  stop: "hammertime 542",
  stop: "hammertime 543",
  stop: "hammertime 544",
  stop: "hammertime 545",
  stop: "hammertime 546",
  stop: "hammertime 547",
  stop: "hammertime 548",
  stop: "hammertime 549",
  stop: "hammertime 550",
  ...
]
iex> Process.info(pid, :message_queue_len)
{:message_queue_len, 1000}
```

Process.send_after

`timer_ref = Process.send_after(pid, :hi, 1000)
`