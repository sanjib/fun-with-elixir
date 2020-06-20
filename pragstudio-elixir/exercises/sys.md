# Debugging and Tracing

- `:sys.get_state(pid)`
- `:sys.trace(pid, true)`
- `:sys.get_status(pid)`

```console
iex> {:ok, pid} = Servy.PledgeServer.start
Starting the pledge server...
{:ok, #PID<0.239.0>}

iex> :sys.get_state(pid)
%Servy.PledgeServer.State{cache_size: 3, pledges: [{"wilma", 15}, {"fred", 25}]}
iex> Servy.PledgeServer.create_pledge("larry", 10)
"pledge-477"

iex> :sys.get_state(pid)                          
%Servy.PledgeServer.State{
  cache_size: 3,
  pledges: [{"larry", 10}, {"wilma", 15}, {"fred", 25}]
}

iex> :sys.get_status(pid)                         
{:status, #PID<0.239.0>, {:module, :gen_server},
 [
   [
     "$ancestors": [#PID<0.237.0>, #PID<0.80.0>],
     "$initial_call": {Servy.PledgeServer, :init, 1},
     rand_seed: {%{
        bits: 58,
        jump: #Function<8.10897371/1 in :rand.mk_alg/1>,
        next: #Function<5.10897371/1 in :rand.mk_alg/1>,
        type: :exrop,
        uniform: #Function<6.10897371/1 in :rand.mk_alg/1>,
        uniform_n: #Function<7.10897371/2 in :rand.mk_alg/1>,
        weak_low_bits: 1
      }, [116178996860784410 | 19548402879745064]}
   ],
   :running,
   #PID<0.239.0>,
   [],
   [
     header: 'Status for generic server Elixir.Servy.PledgeServer',
     data: [
       {'Status', :running},
       {'Parent', #PID<0.239.0>},
       {'Logged events', []}
     ],
     data: [
       {'State',
        %Servy.PledgeServer.State{
          cache_size: 3,
          pledges: [{"curly", 30}, {"moe", 20}, {"larry", 10}]
        }}
     ]
   ]
 ]}

```
