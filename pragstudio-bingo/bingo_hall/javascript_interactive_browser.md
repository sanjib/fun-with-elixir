# JavaScript Code for Interactive Development in the Browser


Run in the Dev console at http://localhost:4000/games/<game-name>

**Channel Test**

```javascript
gameContainer = document.getElementById("game-container")
authToken = gameContainer.getAttribute("data-auth-token")
gameName = gameContainer.getAttribute("data-game-name")
socket = new Phoenix.Socket("/socket", {params: {token: authToken}})
socket.connect()
channel = socket.channel("games:" + gameName, {})
channel.on("game_summary", summary => {console.log("Received summary:", summary)})
channel.join().receive("ok", resp => {console.log("Joined!", resp)})

channel.push("mark_square", {phrase: ""})

channel.on("new_chat_message", msg => {console.log("Received chat:", msg)})
channel.push("new_chat_message", {body: "howdy!"})
```

**Presence Test**

```javascript
gameContainer = document.getElementById("game-container")
authToken = gameContainer.getAttribute("data-auth-token")
gameName = gameContainer.getAttribute("data-game-name")
socket = new Phoenix.Socket("/socket", {params: {token: authToken}})
socket.connect()
channel = socket.channel("games:" + gameName, {})
channel.on("game_summary", summary => {console.log("Received summary:", summary)})

presences = {}
channel.on("presence_state", state => {
    console.log("Presence state:", state)
    presences = Phoenix.Presence.syncState(presences, state)
})
channel.on("presence_diff", diff => {
    console.log("Presence diff:", diff)
    presences = Phoenix.Presence.syncDiff(presences, diff)
})

channel.join().receive("ok", resp => {console.log("Joined!", resp)})
```
