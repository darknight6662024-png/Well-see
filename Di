<!DOCTYPE html>
<html>
<head>
  <title>Dice Hold Game</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    body {
      margin: 0;
      font-family: Arial;
      background: #121212;
      color: white;
      text-align: center;
    }

    h1 {
      margin-top: 20px;
    }

    .dice-container {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin: 30px 0;
    }

    .die {
      width: 70px;
      height: 70px;
      background: white;
      color: black;
      font-size: 30px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 12px;
      cursor: pointer;
      user-select: none;
      transition: transform 0.2s, background 0.2s;
    }

    .held {
      background: #00c6ff;
      color: white;
      transform: scale(1.1);
    }

    .rolling {
      animation: spin 0.3s linear;
    }

    @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    button {
      padding: 12px 20px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      background: #00c6ff;
      color: white;
      cursor: pointer;
      margin: 5px;
    }

    button:disabled {
      opacity: 0.5;
      cursor: not-allowed;
    }

    #rolls {
      margin-top: 10px;
      font-size: 18px;
    }
  </style>
</head>
<body>

<h1>🎲 Dice Hold Game</h1>

<div class="dice-container">
  <div class="die" id="d0">-</div>
  <div class="die" id="d1">-</div>
  <div class="die" id="d2">-</div>
  <div class="die" id="d3">-</div>
  <div class="die" id="d4">-</div>
</div>

<button id="rollBtn">Roll</button>
<button onclick="resetGame()">New Round</button>

<div id="rolls">Rolls left: 3</div>

<script>
let dice = [0,0,0,0,0];
let held = [false,false,false,false,false];
let rollsLeft = 3;
let hasRolled = false;

const rollBtn = document.getElementById("rollBtn");

// INIT CLICK HANDLERS
for(let i=0;i<5;i++){
  document.getElementById("d"+i).onclick = () => toggleHold(i);
}

function rand(){
  return Math.floor(Math.random()*6)+1;
}

function rollDice(){
  if(rollsLeft <= 0) return;

  hasRolled = true;

  for(let i=0;i<5;i++){
    if(!held[i]){
      const dieEl = document.getElementById("d"+i);

      // animation reset
      dieEl.classList.remove("rolling");
      void dieEl.offsetWidth;
      dieEl.classList.add("rolling");

      dice[i] = rand();
      dieEl.textContent = dice[i];
    }
  }

  rollsLeft--;

  if(rollsLeft === 0){
    rollBtn.disabled = true;
  }

  updateUI();
}

function toggleHold(i){
  if(!hasRolled) return; // can't hold before first roll
  if(rollsLeft === 0) return; // lock after last roll

  held[i] = !held[i];

  const die = document.getElementById("d"+i);
  die.classList.toggle("held");
}

function updateUI(){
  document.getElementById("rolls").textContent = "Rolls left: " + rollsLeft;
}

function resetGame(){
  dice = [0,0,0,0,0];
  held = [false,false,false,false,false];
  rollsLeft = 3;
  hasRolled = false;

  for(let i=0;i<5;i++){
    const die = document.getElementById("d"+i);
    die.textContent = "-";
    die.classList.remove("held");
    die.classList.remove("rolling");
  }

  rollBtn.disabled = false;
  updateUI();
}

// BUTTON EVENT
rollBtn.onclick = rollDice;
</script>

</body>
</html>
