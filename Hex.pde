class Hex {
  int l, s, ct;
  Boolean[] walls = new Boolean[6];
  boolean visited;
  color c;
  Boolean[] path = new Boolean[6];
  float g_score,h_score,f_score;
  Hex() {
    this.walls[0] = true; //right
    this.walls[1] = true; //up right
    this.walls[2] = true; //up left
    this.walls[3] = true; //left
    this.walls[4] = true; //down left
    this.walls[5] = true; //down right
    this.c = colorList[1];
    this.visited = false;
  }


  void drawHex () {
    float x = h2r(this.l, this.s, this.ct)[0];
    float y = h2r(this.l, this.s, this.ct)[1];

    fill(this.c); //fill color
    noStroke();
    beginShape();
    for (int i=0; i<6; i++) {
      float theta = i*PI/3;
      float xi = size * cos(theta + PI/6) + x;
      float yi = size * sin(theta + PI/6) + y;
      vertex(xi, yi);
    }
    endShape(CLOSE);

    strokeWeight(2); //draw walls
    strokeCap(ROUND);
    stroke(0);
    for (int i=0; i<6; i++) {
      float theta = i*PI/3;
      if (this.walls[i]) {
        float xi = size * cos(-theta + PI/6) + x;
        float yi = size * sin(-theta + PI/6) + y;
        float xn = size * cos(-theta - PI/6) + x;
        float yn = size * sin(-theta - PI/6) + y;
        line(xi, yi, xn, yn);
      }
    }
    
    textSize(10); //print info
    fill(0, 102, 153);
    //text(str(this.l)+str(this.s)+str(this.ct), x-10, y+5);
    //text(str(deg(x, y)), x-10, y+15);
    //text(int(this.g_score)+' '+'+'+' '+int(this.h_score), x-10, y+15);
  }

  void c_path() { //check possible path - used in maze generation
    for (int i=0; i<6; i++) {
      this.path[i] = false;
      int[] neib = trans(this.l, this.s, this.ct, i);
      if (neib[0]<level & neib[1]<6 & neib[2]<level) {
        if (!h[neib[0]][neib[1]][neib[2]].visited) {
          this.path[i]=true;
          }
        }
      }
    }   
    
  IntList c_walls() { //check possible path - used in solving
    IntList paths = new IntList();
    for (int i=0; i<6; i++) {
      int[] neib = trans(this.l, this.s, this.ct, i);
      if (neib[0]<level & neib[1]<6 & neib[2]<level) {
        if (!this.walls[i]){
          if (!h[neib[0]][neib[1]][neib[2]].visited) {
            paths.append(i);
            }
          }
        }
    }
   return paths;
    
   }   
  
  void h_score(){
    float x = h2r(this.l,this.s,this.ct)[0]-h2r(e[0],e[1],e[2])[0];
    float y = h2r(this.l,this.s,this.ct)[1]-h2r(e[0],e[1],e[2])[1];
    this.h_score = sqrt(x*x+y*y)/size;
  }
  
  void f_score(){
    this.f_score = this.g_score;
  }
  
  void passed() {
    this.c = colorList[4];
  }
}