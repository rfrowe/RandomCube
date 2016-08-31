/* @pjs preload="1/side0.jpg,1/side1.jpg,1/side2.jpg,1/side3.jpg,1/side4.jpg,1/side5.jpg,
2/side0.jpg,2/side1.jpg,2/side2.jpg,2/side3.jpg,2/side4.jpg,2/side5.jpg,
3/side0.jpg,3/side1.jpg,3/side2.jpg,3/side3.jpg,3/side4.jpg,3/side5.jpg,
4/side0.jpg,4/side1.jpg,4/side2.jpg,4/side3.jpg,4/side4.jpg,4/side5.jpg,
5/side0.jpg,5/side1.jpg,5/side2.jpg,5/side3.jpg,5/side4.jpg,5/side5.jpg,
6/side0.jpg,6/side1.jpg,6/side2.jpg,6/side3.jpg,6/side4.jpg,6/side5.jpg,
7/side0.jpg,7/side1.jpg,7/side2.jpg,7/side3.jpg,7/side4.jpg,7/side5.jpg,
8/side0.jpg,8/side1.jpg,8/side2.jpg,8/side3.jpg,8/side4.jpg,8/side5.jpg,
9/side0.jpg,9/side1.jpg,9/side2.jpg,9/side3.jpg,9/side4.jpg,9/side5.jpg"; */


PImage[] pix = new PImage[6];
float rotx = 0;
float roty = 0;
static final int WIDTH = 100;
int level;
int r, b, g;
int pTouchX = 0;
int pTouchY = 0;
int wid = screen.width;
int hig = screen.height;
float rate = 0.01;

void setup() {
  level = 1;
  setComplexity(level);
  if(wid < 768 && hig < 768) {
  	size(0.8 * Math.min(wid, hig),0.8 * Math.min(wid, hig), P3D);
  }
  else {
  	size(500, 500, P3D);
  }
  textureMode(NORMAL);
  String rgb = $("canvas").css("background-color");
  r = parseInt(rgb.substring(rgb.indexOf("(") + 1, rgb.indexOf(",")));
  g = parseInt(rgb.substring(rgb.indexOf(",") + 1, rgb.indexOf(",",rgb.indexOf(",") + 1)));
  b = parseInt(rgb.substring(rgb.indexOf(",",rgb.indexOf(",") + 1) + 1 ,rgb.indexOf(")")));
}

void setComplexity(int complexity) {
  level = complexity;
  pix = new PImage[6];
  for(int i = 0; i < 6; i++) {
    pix[i] = loadImage(level + "/side" + i + ".jpg");
  }
}

int getComplexity() {
	return level;
}

void draw() {
  background(r, g, b);
  noStroke();
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  if(wid < 768 && hig < 768) {
  	scale(160 - (768 - Math.min(wid, hig)) * 0.19531);
  } else {
  	scale(160);
  }
  TexturedCube(pix);
  fill(255,255,255);
}

void TexturedCube(PImage[] pix) {
  beginShape(QUADS);
  texture(pix[0]);
  // +Z "front" face
  vertex(-1, -1, 1, 0, 0);
  vertex(1, -1, 1, 1, 0);
  vertex(1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(pix[1]);
  // -Z "back" face
  vertex(-1, -1, -1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(pix[2]);
  // +Y "bottom" face
  vertex(-1, 1, 1, 0, 0);
  vertex(-1, 1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(1, 1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(pix[3]);
  // -Y "top" face
  vertex(-1, -1, 1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(1, -1, -1, 1, 1);
  vertex(1, -1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(pix[4]);
  // +X "right" face
  vertex(1, -1, 1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(1, 1, 1, 0, 1);
  endShape();

  beginShape(QUADS);
  texture(pix[5]);
  // -X "left" face
  vertex(-1, -1, 1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex(-1, 1, 1,0, 1);
  endShape();
}

void mouseDragged() {
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}

/*void touchMove(t) {
  int touchX = t.touches[0].offsetX;
  int touchY = t.touches[0].offsetY;
  rotx += (pTouchY - touchY) * rate;
  roty += (pTouchX -touchX ) * rate;
  pTouchX = touchX;
  pTouchY = touchY;
}*/
