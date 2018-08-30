  int[] checkPawnR = new int[] {};
  int[] checkPawnC = new int[] {};
  
  int[] checkKnightR = new int[] {};
  int[] checkKnightC = new int[] {};
  
  int[] checkAxisR = new int[] {};
  int[] checkAxisC = new int[] {};
  
  int[] checkDiagsR = new int[] {};
  int[] checkDiagsC = new int[] {};
  
  int[] checkKingR = new int[] {};
  int[] checkKingC = new int[] {};
  
int cUseR;
int cUseC;

boolean check;
boolean checkmate;
int whoCheck = -1;

int[][] tempC = {
  {10, 8, 9, 11, 12, 9, 8, 10},
  {7, 7, 7, 7, 7, 7, 7, 7},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {4, 2, 3, 5, 6, 3, 2, 4}
};

int[][] C = {
  {10, 8, 9, 11, 12, 9, 8, 10},
  {7, 7, 7, 7, 7, 7, 7, 7},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {4, 2, 3, 5, 6, 3, 2, 4}
};
//which piece is there: 0 is nopiece, 1-6 is player one's, and 7-12 is player two's

int whiteKingR = 7;
int whiteKingC = 4;
int blackKingR = 0;
int blackKingC = 4;

int[] possibleMovesR = new int[0]; //possible spaces to move from origin point
int[] possibleMovesC = new int[0]; //possible spaces to move from origin point

int turn = 0;

boolean clicked = false;

boolean askSwitch = false;

int spaceSelectedR; //which space (of 0-63) is currecntly selected
int spaceSelectedC; //which space (of 0-63) is currecntly selected
int originSpaceR = -1;
int originSpaceC;
int isSelect = 0;
int[] pMoveR = new int[0];
int[] pMoveC = new int[0];

int up = -1;
int right = 1;
int down = 1;
int left = -1;

PImage white_pawn;
PImage black_pawn;
PImage white_knight;
PImage black_knight;
PImage white_bishop;
PImage black_bishop;
PImage white_rook;
PImage black_rook;
PImage white_queen;
PImage black_queen;
PImage white_king;
PImage black_king;

void setup(){
  size(800,800);
  
  white_pawn = loadImage("http://i.imgur.com/KorGez3.png");
  black_pawn = loadImage("http://i.imgur.com/D5irZav.png");
  white_knight = loadImage("http://i.imgur.com/cCr3gSV.png");
  black_knight = loadImage("http://i.imgur.com/vK3zq0U.png");
  white_bishop = loadImage("http://i.imgur.com/G3vZk5c.png");
  black_bishop = loadImage("http://i.imgur.com/69EySJN.png");
  white_rook = loadImage("http://i.imgur.com/Cw9rWEY.png");
  black_rook = loadImage("http://i.imgur.com/KQAnjvx.png");
  white_queen = loadImage("http://i.imgur.com/LEhjC35.png");
  black_queen = loadImage("http://i.imgur.com/yLhMQFW.png");
  white_king = loadImage("http://i.imgur.com/E77IVwC.png");
  black_king = loadImage("http://i.imgur.com/3ezOoyJ.png");
}


void switchTurn(){
  if(turn == 0){
    turn = 1;
    up = 1;
    right = -1;
    down = -1;
    left = 1;
    if(isCheck(1, -1, 0)){
      check = true;
      whoCheck = 1;
    }
    else{
      check = false;
      whoCheck = -1;
    }
  }
  else if(turn == 1){
    turn = 0;
    up = -1;
    right = 1;
    down = 1;
    left = -1;
    if(isCheck(0, -1, 0)){
      check = true;
      whoCheck = 0;
    }
    else{
      check = false;
      whoCheck = -1;
    }
  }
  possibleMovesR = new int[0]; //clears array
  possibleMovesC = new int[0]; //clears array
}


void possibleMoves(){ //updates possibleMoves array for originSpace
  possibleMovesR = new int[0]; //clears array
  possibleMovesC = new int[0]; //clears array
  
  pMoveR = new int[0];
  pMoveC = new int[0];
  
  if(C[originSpaceR][originSpaceC] == 1 || C[originSpaceR][originSpaceC] == 7){
    
    
    if(originSpaceR + up > -1 && originSpaceR + up < 8 && originSpaceC > -1 && originSpaceC < 8){
    if(C[originSpaceR + up][originSpaceC] == 0  ){
      pMoveR = append(pMoveR, originSpaceR + up);
      pMoveC = append(pMoveC, originSpaceC);
    }
    }
    
    if(originSpaceR + up + up > -1 && originSpaceR + up + up < 8 && originSpaceC > -1 && originSpaceC < 8){
    if((C[originSpaceR + up][originSpaceC] == 0) && (C[originSpaceR + up + up][originSpaceC] == 0) && ((turn == 0 && originSpaceR == 6 ) || (turn == 1 && originSpaceR == 1 ) )){
      pMoveR = append(pMoveR, originSpaceR + up + up);
      pMoveC = append(pMoveC, originSpaceC);
    }
    }
    
    if(originSpaceR + up > -1 && originSpaceR + up < 8 && originSpaceC + left > -1 && originSpaceC + left < 8){
    if((C[originSpaceR + up][originSpaceC + left] != 0) && (!(isItMine(originSpaceR + up, originSpaceC + left)) ) ){
      pMoveR = append(pMoveR, originSpaceR + up);
      pMoveC = append(pMoveC, originSpaceC + left);
    }
    }
    
    if(originSpaceR + up > -1 && originSpaceR + up < 8 && originSpaceC + right > -1 && originSpaceC + right < 8){
    if((C[originSpaceR + up][originSpaceC + right] != 0) && (!(isItMine(originSpaceR + up, originSpaceC + right)) ) ){
      pMoveR = append(pMoveR, originSpaceR + up);
      pMoveC = append(pMoveC, originSpaceC + right);
    }
    }
    
    
    
  }
  
  if(C[originSpaceR][originSpaceC] == 2 || C[originSpaceR][originSpaceC] == 8){
    pMoveR = new int[] {
      originSpaceR + up + up,
      originSpaceR + up,
      originSpaceR + down,
      originSpaceR + down + down,
      originSpaceR + down + down,
      originSpaceR + down,
      originSpaceR + up,
      originSpaceR + up + up
    };
    pMoveC = new int[] {
      originSpaceC + right,
      originSpaceC + right + right,
      originSpaceC + right + right,
      originSpaceC + right,
      originSpaceC + left,
      originSpaceC + left + left,
      originSpaceC + left + left,
      originSpaceC + left
    };
  }
  
  if(C[originSpaceR][originSpaceC] == 3 || C[originSpaceR][originSpaceC] == 9){
    appDirect(up, right, 0);
    appDirect(up, left, 0);
    appDirect(down, right, 0);
    appDirect(down, left, 0);
  }
  
  if(C[originSpaceR][originSpaceC] == 4 || C[originSpaceR][originSpaceC] == 10){
    appDirect(up, 0, 0);
    appDirect(0, left, 0);
    appDirect(0, right, 0);
    appDirect(down, 0, 0);
  }
  
  if(C[originSpaceR][originSpaceC] == 5 || C[originSpaceR][originSpaceC] == 11){
    appDirect(up, right, 0);
    appDirect(up, left, 0);
    appDirect(down, right, 0);
    appDirect(down, left, 0);
    
    appDirect(up, 0, 0);
    appDirect(0, left, 0);
    appDirect(0, right, 0);
    appDirect(down, 0, 0);
  }
  
  
  if(C[originSpaceR][originSpaceC] == 6 || C[originSpaceR][originSpaceC] == 12){
    pMoveR = new int[] {originSpaceR + up, originSpaceR + up, originSpaceR, originSpaceR + down, originSpaceR + down, originSpaceR + down, originSpaceR, originSpaceR + up};
    pMoveC = new int[] {originSpaceC, originSpaceC + right, originSpaceC + right, originSpaceC + right, originSpaceC, originSpaceC + left, originSpaceC + left, originSpaceC + left};
  }
  
  
  
    int k = 0;
    while(k < pMoveR.length && k < pMoveC.length){
      if((0 <= pMoveR[k] && pMoveR[k] <= 7 && 0 <= pMoveC[k] && pMoveC[k] <= 7 && !isItMine(pMoveR[k],pMoveC[k]))){
        for(int cet = 0; cet < 8; cet++){
          for(int set = 0; set < 8; set++){
            tempC[cet][set] = C[cet][set];
          }
        }
        tempC[pMoveR[k]][pMoveC[k]] = tempC[originSpaceR][originSpaceC];
        tempC[originSpaceR][originSpaceC] = 0;
        if(!isCheck(turn, -1, -1)){
          possibleMovesR = append(possibleMovesR, pMoveR[k]);
          possibleMovesC = append(possibleMovesC, pMoveC[k]);
        }
      }
      k++;
    }
}


void appDirect(int rTrack, int cTrack, int ind){
  int i, j;
  int targetSpaceR, targetSpaceC;
  for(i = 1, j = 0; i < 8 && j < 1; i++){
    if(ind == 0){
      targetSpaceR = originSpaceR + (i * rTrack);
      targetSpaceC = originSpaceC + (i * cTrack);
    }
    else{
      targetSpaceR = cUseR + (i * rTrack);
      targetSpaceC = cUseC + (i * cTrack);
    }
    
    
    if(0 <= targetSpaceR && targetSpaceR <= 7 && 0 <= targetSpaceC && targetSpaceC <= 7){
      
      if(turn == 0 && (tempC[targetSpaceR][targetSpaceC] == 0 || tempC[targetSpaceR][targetSpaceC] > 6)||(turn == 1 && (tempC[targetSpaceR][targetSpaceC] == 0 || tempC[targetSpaceR][targetSpaceC] < 7))){
        if(ind == -1){
          checkAxisR = append(checkAxisR, targetSpaceR);
          checkAxisC = append(checkAxisC, targetSpaceC);
        }
        if(ind == -2){
          checkDiagsR = append(checkDiagsR, targetSpaceR);
          checkDiagsC = append(checkDiagsC, targetSpaceC);
        }
      }
      
      if(turn == 0 && (C[targetSpaceR][targetSpaceC] == 0 || C[targetSpaceR][targetSpaceC] > 6)||(turn == 1 && (C[targetSpaceR][targetSpaceC] == 0 || C[targetSpaceR][targetSpaceC] < 7))){
        if(ind == 0){
          pMoveR = append(pMoveR, targetSpaceR);
          pMoveC = append(pMoveC, targetSpaceC);
        }
        if(ind == 1){
          checkAxisR = append(checkAxisR, targetSpaceR);
          checkAxisC = append(checkAxisC, targetSpaceC);
        }
        if(ind == 2){
          checkDiagsR = append(checkDiagsR, targetSpaceR);
          checkDiagsC = append(checkDiagsC, targetSpaceC);
        }
      }
      if((C[targetSpaceR][targetSpaceC] != 0 && ind > -1) || (tempC[targetSpaceR][targetSpaceC] != 0 && ind < 0)){
        j++;
      }
    }
  }
  
}



boolean isCheck(int a, int r, int c){
  int cPawn, cKnight, cBishop, cRook, cQueen, cKing;
  int tempKc = -1;
  int tempKr = -1;
  if(c == -1){
    for(int l = 0; l < 8; l++){
      for(int m = 0; m < 8; m++){
        if(tempC[l][m] == 6 && a == 0){
          tempKr = l;
          tempKc = m;
        }
        if(tempC[l][m] == 12 && a == 1){
          tempKr = l;
          tempKc = m;
        }
      }
    }
  }
  
  cUseR = -1;
  cUseC = -1;
  
    cPawn = -1;
    cKnight = -1;
    cBishop = -1;
    cRook = -1;
    cQueen = -1;
    cKing = -1;
  
  if(a == 0){
    cUseR = whiteKingR;
    cUseC = whiteKingC;
    cPawn = 7;
    cKnight = 8;
    cBishop = 9;
    cRook = 10;
    cQueen = 11;
    cKing = 12;
  }
  if(a == 1){
    cUseR = blackKingR;
    cUseC = blackKingC;
    cPawn = 1;
    cKnight = 2;
    cBishop = 3;
    cRook = 4;
    cQueen = 5;
    cKing = 6;
  }
  if(r != -1){
    cUseR = r;
    cUseC = c;
  }
  if(c == -1){
    cUseR = tempKr;
    cUseC = tempKc;
  }
  
  
  
  
  checkPawnR = new int[] { cUseR + up, cUseR + up };
  checkPawnC = new int[] { cUseC + left, cUseC + right };
  
  checkKnightR = new int[] {
      cUseR + up + up,
      cUseR + up,
      cUseR + down,
      cUseR + down + down,
      cUseR + down + down,
      cUseR + down,
      cUseR + up,
      cUseR + up + up,
  };
  checkKnightC = new int[] {
      cUseC + right,
      cUseC + right + right,
      cUseC + right + right,
      cUseC + right,
      cUseC + left,
      cUseC + left + left,
      cUseC + left + left,
      cUseC + left
  };
  
  checkAxisR = new int[] {};
  checkAxisC = new int[] {};
  if(c != -1){
  appDirect(up, 0, 1);
  appDirect(0, right, 1);
  appDirect(down, 0, 1);
  appDirect(0, left, 1);
  }
  else{
  appDirect(up, 0, -1);
  appDirect(0, right, -1);
  appDirect(down, 0, -1);
  appDirect(0, left, -1);
  }
  
  checkDiagsR = new int[] {};
  checkDiagsC = new int[] {};
  if(c != -1){
  appDirect(up, right, 2);
  appDirect(down, right, 2);
  appDirect(down, left, 2);
  appDirect(up, left, 2);
  }
  else{
  appDirect(up, right, -2);
  appDirect(down, right, -2);
  appDirect(down, left, -2);
  appDirect(up, left, -2);
  }
  
  checkKingR = new int[] {
  cUseR + up, 
  cUseR + up, 
  cUseR, 
  cUseR + down, 
  cUseR + down, 
  cUseR + down, 
  cUseR, 
  cUseR + up
  };
  checkKingC = new int[] {
  cUseC, 
  cUseC + right, 
  cUseC + right, 
  cUseC + right, 
  cUseC, 
  cUseC + left, 
  cUseC + left, 
  cUseC + left
  };
  
  int k = 0;
  int i;
  int targetR, targetC;
  k = 0;
  for(i = 0; i < checkPawnR.length; i++){
    targetR = checkPawnR[i];
    targetC = checkPawnC[i];
    if(targetR > -1 && targetR < 8 && targetC > -1 && targetC < 8){
    if((C[targetR][targetC] == cPawn && c != -1) || (tempC[targetR][targetC] == cPawn && c == -1))
      k++;
    }
  }
  for(i = 0; i < checkKnightR.length; i++){
    targetR = checkKnightR[i];
    targetC = checkKnightC[i];
    if(targetR > -1 && targetR < 8 && targetC > -1 && targetC < 8){
    if((C[targetR][targetC] == cKnight && c != -1) || (tempC[targetR][targetC] == cKnight && c == -1))
      k++;
    }
  }
  for(i = 0; i < checkAxisR.length; i++){
    targetR = checkAxisR[i];
    targetC = checkAxisC[i];
    if(targetR > -1 && targetR < 8 && targetC > -1 && targetC < 8){
    if(((C[targetR][targetC] == cRook || C[targetR][targetC] == cQueen) && c != -1) || ((tempC[targetR][targetC] == cRook || tempC[targetR][targetC] == cQueen) && c == -1))
      k++;
    }
  }
  for(i = 0; i < checkDiagsR.length; i++){
    targetR = checkDiagsR[i];
    targetC = checkDiagsC[i];
    if(targetR > -1 && targetR < 8 && targetC > -1 && targetC < 8){
    if(((C[targetR][targetC] == cBishop || C[targetR][targetC] == cQueen) && c != -1) || ((tempC[targetR][targetC] == cBishop || tempC[targetR][targetC] == cQueen) && c == -1))
      k++;
  }}
  for(i = 0; i < checkKingR.length; i++){
    targetR = checkKingR[i];
    targetC = checkKingC[i];
    if(targetR > -1 && targetR < 8 && targetC > -1 && targetC < 8){
    if((C[targetR][targetC] == cKing && c != -1) || (tempC[targetR][targetC] == cKing && c == -1))
      k++;
  }}
  
  if(k > 0){
    return(true);
  }
  else{
    return(false);
  }
}


boolean isItMine(int r, int c){
  if((C[r][c] != 0) &&     ( (turn == 0 && C[r][c] < 7) || (turn == 1 && C[r][c] > 6) )    ){
    return(true);
  } else{
    return(false);
  }
}


void draw(){
  textAlign(LEFT);
  textSize(sqrt(height*width)/3.125);
  strokeWeight(sqrt(height*width)/40);
  
  //board's boxes
  background(185);
  noStroke();
  for(int diag = -8; diag<17; diag+=2){
    for(int box = 0; box < 9; box++){
      fill(255);
      rect(width/8*box+width/8*diag, height/8*box, width/8, height/8);
  } }
  //
  
  // pmove boxes
  for(int lkk = 0; isSelect == 1 && lkk < possibleMovesR.length; lkk++){
    fill(255);
    rect(width/8*possibleMovesC[lkk], height/8*possibleMovesR[lkk], width/8, height/8);
    fill(220, 220, 0, 127);
    rect(width/8*possibleMovesC[lkk], height/8*possibleMovesR[lkk], width/8, height/8);
  }
  
  if(check){
    if(whoCheck == 0){
      fill(255);
      rect(width/8*whiteKingC, height/8*whiteKingR, width/8, height/8);
      fill(200, 0, 0, 150);
      rect(width/8*whiteKingC, height/8*whiteKingR, width/8, height/8);
    }
    if(whoCheck == 1){
      fill(255);
      rect(width/8*blackKingC, height/8*blackKingR, width/8, height/8);
      fill(200, 0, 0, 150);
      rect(width/8*blackKingC, height/8*blackKingR, width/8, height/8);
    }
    
  }
  
  
  fill(255);
  rect(width/8*originSpaceC, height/8*originSpaceR, width/8, height/8);
  fill(0, 130, 0, 120);
  rect(width/8*originSpaceC, height/8*originSpaceR, width/8, height/8);
  
  //board's lines
  fill(0);
  for(int line = 0; line < 9; line++){
    rect(width/8*line-(sqrt(height*width)/40/6), 0, (sqrt(height*width)/40/3), height);
    rect(0, height/8*line-(sqrt(height*width)/40/6), width, (sqrt(height*width)/40/3));
  }
  //
  
  stroke(0);
  textAlign(LEFT);
  textSize(sqrt(height*width)/27);
  
  for(int j = 0; j < 8; j++){
    for(int i = 0; i < 8; i++){
      if(C[j][i] == 1){
        image(white_pawn, i * 100 + 15, j * 100 + 15, 70, 70);
      }
      if(C[j][i] == 7){
        image(black_pawn, i * 100 + 15, j * 100 + 15, 70, 70);
      }
      if(C[j][i] == 2){
        image(white_knight, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 8){
        image(black_knight, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 3){
        image(white_bishop, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 9){
        image(black_bishop, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 4){
        image(white_rook, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 10){
        image(black_rook, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 5){
        image(white_queen, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 11){
        image(black_queen, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 6){
        image(white_king, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      if(C[j][i] == 12){
        image(black_king, i * 100 + 10, j * 100 + 10, 80, 80);
      }
      
      
      
      
      
    }
  }
  if(askSwitch){
 fill(255); stroke(0); strokeWeight(5); textAlign(CENTER); textSize(64); 
 quad(250,200,550,200,550,300,250,300); 
 quad(250,300,550,300,550,400,250,400);
 quad(250,400,550,400,550,500,250,500);
 quad(250,500,550,500,550,600,250,600);
 fill(0);
 text("QUEEN",400,275);
 text("ROOK",400,375);
 text("BISHOP",400,475);
 text("KNIGHT",400,575);
 } 
 
}
int pawnR;
int pawnC;

void moveMade(int movetoSpaceR, int movetoSpaceC){ //executes the data exchanges necessary when a move is made
  C[movetoSpaceR][movetoSpaceC] = C[originSpaceR][originSpaceC];
  C[originSpaceR][originSpaceC] = 0;
  if((C[movetoSpaceR][movetoSpaceC] == 1 && movetoSpaceR == 0) || (C[movetoSpaceR][movetoSpaceC] == 7 && movetoSpaceR == 7)){
    askSwitch=true; pawnR = movetoSpaceR; pawnC = movetoSpaceC;
   }
   if(C[movetoSpaceR][movetoSpaceC] == 6  || C[movetoSpaceR][movetoSpaceC] == 12){
     if(C[movetoSpaceR][movetoSpaceC] == 6){
       whiteKingR = movetoSpaceR;
       whiteKingC = movetoSpaceC;
     }
     if(C[movetoSpaceR][movetoSpaceC] == 12){
       blackKingR = movetoSpaceR;
       blackKingC = movetoSpaceC;
     }
     
   }
  isSelect = 0;
  originSpaceR = -1;
  switchTurn();
}


void mousePressed(){
  
  for(int i = 0; i < 64; i++){
    for(int horiz = 0; horiz < 8; horiz++){
      for(int vert = 0; vert < 8; vert++){
        float xMin = width/8*vert;
        float yMin = height/8*horiz;
        float xMax = xMin + width/8;
        float yMax = yMin + height/8;
        if (mouseX>xMin && mouseX<xMax && mouseY>yMin && mouseY<yMax){
            spaceSelectedR = horiz;
            spaceSelectedC = vert;
        if( isSelect == 0 && isItMine(spaceSelectedR, spaceSelectedC) ){ 
          originSpaceR = spaceSelectedR; 
          originSpaceC = spaceSelectedC;
          possibleMoves();
          if(possibleMovesR.length > 0)
          isSelect = 1; 
        }
        
        if(isSelect == 1 && (C[originSpaceR][originSpaceC] == 6 || C[originSpaceR][originSpaceC] == 12) && originSpaceR == spaceSelectedR && originSpaceC == spaceSelectedC){
          checkmate = true;
          whoCheck = turn;
        }
        
        if(isSelect == 1 && !isItMine(spaceSelectedR, spaceSelectedC)){ 

          int k = 0;
          for(int j = 0; j < possibleMovesR.length && k < 1; j++){
            if(spaceSelectedR == possibleMovesR[j] && spaceSelectedC == possibleMovesC[j]){
              k++;
            }
          }
          if(k == 1){
            moveMade(spaceSelectedR, spaceSelectedC);
          } else{
            isSelect = 0;
            originSpaceR = -1;
          }
        
} } } } }
  
  
  
  if(250<mouseX && mouseX<550 && 200<mouseY && mouseY<300 && askSwitch){
  askSwitch=false;
  if(C[pawnR][pawnC] == 1 && pawnR == 0){ C[pawnR][pawnC] = 5;}
   
    if(C[pawnR][pawnC] == 7 && pawnR == 7){ C[pawnR][pawnC] = 11;}
  }
  if(250<mouseX && mouseX<550 && 300<mouseY && mouseY<400 && askSwitch){
  askSwitch=false;
  if(C[pawnR][pawnC] == 1 && pawnR == 0){ C[pawnR][pawnC] = 4;}
   
  if(C[pawnR][pawnC] == 7 && pawnR == 7){ C[pawnR][pawnC] = 10;}
  }
  if(250<mouseX && mouseX<550 && 400<mouseY && mouseY<500 && askSwitch){
  askSwitch=false;
  if(C[pawnR][pawnC] == 1 && pawnR == 0){ C[pawnR][pawnC] = 3;}
   
  if(C[pawnR][pawnC] == 7 && pawnR == 7){ C[pawnR][pawnC] = 9;}
  }
  if(250<mouseX && mouseX<550 && 500<mouseY && mouseY<600 && askSwitch){
  askSwitch=false;
  if(C[pawnR][pawnC] == 1 && pawnR == 0){ C[pawnR][pawnC] = 2;}
   
  if(C[pawnR][pawnC] == 7 && pawnR == 7){ C[pawnR][pawnC] = 8;}
  }
}