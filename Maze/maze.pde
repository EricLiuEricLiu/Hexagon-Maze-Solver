final int size = 5;   // size of single cell
final int level = 25;  // level of cells
color[] colorList = {color(0,0,0),color(255,255,255),color(255,0,0),color(0,255,0),color(0,0,255),color(77,77,77),color(12,34,56)};
Hex[][][] h = new Hex[level][6][level];
int[] s = {level-1,2,0}; //start
int[] e = {level-1,5,0}; //end
int step;
IntList sp = new IntList();
IntList cp = new IntList();
boolean end = false;


void setup () {
  size(800, 800);
  //background(colorList[1]);
  initiate();
  updateMap();
  h[s[0]][s[1]][s[2]].c = colorList[5];
  h[e[0]][e[1]][e[2]].c = colorList[3];
  genMaze(level-1,2,0);
  clear_visit();
  g_score(e[0],e[1],e[2],0);
  clear_visit();
  //astar(s[0],s[1],s[2],0,0,0);
  //println(h[10][4][9].walls);
  //h[10][4][8].g_score();
  //println(h[10][4][8].g_score);
  sp.append(s[0]);
  sp.append(s[1]);
  sp.append(s[2]);
}


void draw () {
  if (end == false) {
    updateMap();
    int[] cur = {sp.get(sp.size()-3),sp.get(sp.size()-2),sp.get(sp.size()-1)};
    h[cur[0]][cur[1]][cur[2]].visited = true;
    println(cur);
    println(h[cur[0]][cur[1]][cur[2]].c_walls());
    println(sp);
    println(cp);
  
    if(h[cur[0]][cur[1]][cur[2]].c_walls().size() > 1) {
      int[] dir = h[cur[0]][cur[1]][cur[2]].c_walls().array();
      float best_dis = 10000;
      int best_dir = 6;
      for(int i=0;i<dir.length;i++){
        int[] neib = trans(cur[0],cur[1],cur[2],dir[i]);
        if (neib[0]<level & neib[1]<6 & neib[2]<level) {
          if (h[neib[0]][neib[1]][neib[2]].f_score < best_dis){
            best_dis = h[neib[0]][neib[1]][neib[2]].f_score;
            best_dir = i;
          }
        }
      }
      int[] next = trans(cur[0],cur[1],cur[2],dir[best_dir]);
      h[next[0]][next[1]][next[2]].passed();
      sp.append(next[0]);
      sp.append(next[1]);
      sp.append(next[2]);
      cp.append(cur[0]);
      cp.append(cur[1]);
      cp.append(cur[2]);
    } else if (h[cur[0]][cur[1]][cur[2]].c_walls().size() == 1){
      int[] next = trans(cur[0],cur[1],cur[2],h[cur[0]][cur[1]][cur[2]].c_walls().get(0));
      h[next[0]][next[1]][next[2]].passed();
      sp.append(next[0]);
      sp.append(next[1]);
      sp.append(next[2]);
    } else if (h[cur[0]][cur[1]][cur[2]].c_walls().size() == 0){
      if(h[cp.get(cp.size()-3)][cp.get(cp.size()-2)][cp.get(cp.size()-1)].c_walls().size() == 0){
        cp.remove(cp.size()-1);
        cp.remove(cp.size()-1);
        cp.remove(cp.size()-1);
      }
      sp.append(cp.get(cp.size()-3));
      sp.append(cp.get(cp.size()-2));
      sp.append(cp.get(cp.size()-1));
    }
    if (cur[0] == e[0] & cur[1] == e[1] & cur[2] == e[2]) {
      fin();
    }
  }
}


void updateMap () {
  //background(colorList[1]);
  h[0][0][0].drawHex();
  for (int i = 1; i<level; i++) {
    for (int j = 0; j<6; j++) {
      for (int k = 0; k<i; k++) {
        h[i][j][k].drawHex();
      }
    }
  }
}


void initiate() { //register all cells
  h[0][0][0] = new Hex();
  h[0][0][0].l=0;
  h[0][0][0].s=0;
  h[0][0][0].ct=0;
  for (int i = 1; i<level; i++) {
    for (int j = 0; j<6; j++) {
      for (int k = 0; k<i; k++) {
        h[i][j][k] = new Hex();
        h[i][j][k].l=i;
        h[i][j][k].s=j;
        h[i][j][k].ct=k;
        h[i][j][k].h_score();
      }
    }
  }
}


void clear_visit() { //clear visit record
  h[0][0][0].visited = false;
  h[0][0][0].c_path();
  h[0][0][0].h_score();
  //h[0][0]0].g_score();
  for (int i = 1; i<level; i++) {
    for (int j = 0; j<6; j++) {
      for (int k = 0; k<i; k++) {
        h[i][j][k].visited = false;
        h[i][j][k].h_score();
        h[i][j][k].f_score();
        
      }
    }
  }
}


void genMaze(int l, int s, int c){ //initiate maze using Depth-first search
  IntList inventory = new IntList();
  h[l][s][c].visited = true;
  h[l][s][c].c_path();
  for (int i = 0; i <6; i++){if(h[l][s][c].path[i]){inventory.append(i);}}
  inventory.shuffle();
  for(int i =0; i < inventory.size(); i++) {
    h[l][s][c].c_path();
    if(h[l][s][c].path[inventory.get(i)]){
      int dir = inventory.get(i);
      int[] neib = trans(h[l][s][c].l,h[l][s][c].s,h[l][s][c].ct,dir);
      //println(neib);
      h[l][s][c].walls[dir] = false;
      h[neib[0]][neib[1]][neib[2]].walls[opp(dir)] = false;
      step++;
      genMaze(neib[0],neib[1],neib[2]);
      h[l][s][c].g_score=step;
    }  
  }
  step=0;
}

void g_score(int l, int s, int c, int g){ //initiate maze using Depth-first search
  IntList inventory = new IntList();
  h[l][s][c].visited = true;
  h[l][s][c].g_score = g;
  inventory = h[l][s][c].c_walls();
  g++;
  for(int i = 0; i < inventory.size(); i++) {
    if(h[l][s][c].c_walls().hasValue(inventory.get(i))){
      int dir = inventory.get(i);
      int[] neib = trans(h[l][s][c].l,h[l][s][c].s,h[l][s][c].ct,dir);
      g_score(neib[0],neib[1],neib[2],g);
    }
  }
}

void fin(){
  for (int i = 0; i < sp.size()/3; i++){
    int[] cur = {sp.get(i*3),sp.get(i*3+1),sp.get(i*3+2)};
    h[cur[0]][cur[1]][cur[2]].c = colorList[3];
  }
  end = true;
  updateMap();
}

float[] h2r (int level, int side, int ct) { //Hexagon coordinate to rectangular coordinate
  float x, y, r, theta;
  x = sqrt(3) * size * (level - 0.5 * ct);
  y = ct * 1.5 * size;
  r = sqrt(x*x + y*y);
  theta = atan(y/x) + side*PI/3;
  if (level==0) {x = 0;y = 0;} else {
    x = r * cos(-theta);
    y = r * sin(-theta);}
  float[]pos = {x+400, y+400};
  return pos;
}


int[] r2h (float x, float y){ //Rectangular coordinate to hexagon coordinate
  int l,s,c;
  x = (x-(width/2))/size;
  y = (y-(height/2))/size;
  float r = sqrt(x*x + y*y);
  float theta = (acos(x/r));
  if (!(y<0 || (y==0 & x>0))) {theta = 2*PI-theta;}
  float ltheta = theta%(PI/3)+PI/3 - theta;
  l = -round((-x*sin(ltheta)+y*cos(ltheta))/(1.5));
  s = floor(theta/(PI/3)+0.000001);
  c = round((theta%(PI/3))/(PI/3/l));
  if (c == l){c=0;}
  int[]pos = {l,s,c};
  return pos;
}


int[] trans(int level, int side, int ct, int change){//input: hex cordinate, direction of movement
  float x = 0;                                       //output: new hex cordinate
  float y = 0;
  float a = size * sqrt(3)/2;
  float b = size * 1.5;
  if (change == 0) {x+=2*a;}
  if (change == 1) {x+=a;y-=b;}
  if (change == 2) {x-=a;y-=b;}
  if (change == 3) {x-=2*a;}
  if (change == 4) {x-=a;y+=b;}
  if (change == 5) {x+=a;y+=b;}
  return r2h(h2r(level,side,ct)[0]+x,h2r(level,side,ct)[1]+y);
}


int opp (int a) { //in: direction out: opposite direction
  if (a<3) {a+=3;} else {a-=3;}
  return a;
}
