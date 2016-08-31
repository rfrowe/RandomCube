import org.qscript.*;
import org.qscript.editor.*;
import org.qscript.errors.*;
import org.qscript.events.*;
import org.qscript.eventsonfire.*;
import org.qscript.operator.*;
import javax.swing.JOptionPane;
import java.util.Random;

PImage[] pix = new PImage[6];
float rotx = 0; 
float roty = 0; 
static final int WIDTH = 100;

enum Face {FRONT,BACK,BOTTOM,TOP,RIGHT,LEFT};
void setup() { 
    for(int complexity = 1; complexity < 10; complexity++) {
      Function[] rgbFunc = new Function[3];
      println("Complexity of " + complexity);
      rgbFunc[0] = new Function(complexity);
      rgbFunc[1] = new Function(complexity);
      rgbFunc[2] = new Function(complexity);
      
      println(rgbFunc[0].getFunc());
      println();
      println(rgbFunc[1].getFunc());
      println();
      println(rgbFunc[2].getFunc());
      
      for(Face f : Face.values()) {
        genFace(f, rgbFunc).save("" + complexity + "/side" + f.ordinal() + ".jpg");
        System.out.printf("%.2f%% Done with complex. %d%n", (f.ordinal() + 1) * 100 / (double) Face.values().length, complexity);
      }
    }
} 

void keyPressed() {
  save();
}

void save() {
    for(Face f : Face.values()) {
      pix[f.ordinal()].save("/" + f.ordinal() + "/side" + f.ordinal() + ".jpg");
    } 
}

PImage genFace(Face f, Function[] rgbFunc) {
  PImage img = createImage(WIDTH, WIDTH, RGB);
  for(int i = 0; i < WIDTH; i++) {
    for(int j = 0; j < WIDTH; j++) {
      
      float[] rgb;
      
      switch(f) {
        case FRONT:
          rgb = getRGBValues(rgbFunc, new int[] {i,j,0});
          break;
        case BACK:
          rgb = getRGBValues(rgbFunc, new int[] {i,j,WIDTH});
          break;
        case TOP:
          rgb = getRGBValues(rgbFunc, new int[] {j,0,i});
          break;
        case BOTTOM:
          rgb = getRGBValues(rgbFunc, new int[] {j,WIDTH,i});
          break;
        case LEFT:
          rgb = getRGBValues(rgbFunc, new int[] {0,j,i});
          break;
        default:
          rgb = getRGBValues(rgbFunc, new int[] {WIDTH,j,i});
      }
      
      img.set(i, j, color(rgb[0],rgb[1],rgb[2]));
      //println(x + ", " + y + "\tr:" + r + " g:" + g + " b:" + b + "\tfoo:" + foo + " bar:" + bar + " baz:" + baz);
    }
    //println("row " + i);
  } 
  return img;
}

float[] getRGBValues(Function[] rgbFunc, int[] xyz) {
    float d = map(xyz[0], 0, WIDTH, -1, 1);
    float e = map(xyz[1], 0, WIDTH, -1, 1);
    float f = map(xyz[2], 0, WIDTH, -1, 1);
    
    float r = map(rgbFunc[0].eval(d,e,f),-1,1,0,255);
    float g = map(rgbFunc[1].eval(d,e,f),-1,1,0,255);
    float b = map(rgbFunc[2].eval(d,e,f),-1,1,0,255);
    
    return new float[] {r,g,b};
}

void draw() 
{ 
  background(0); 
  noStroke(); 
  translate(width/2.0, height/2.0, -100); 
  rotateX(rotx); 
  rotateY(roty); 
  scale(150); 
  //TexturedCube(pix); 
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
  float rate = 0.01; 
  rotx += (pmouseY-mouseY) * rate; 
  roty += (mouseX-pmouseX) * rate; 
} 

class Function {
  String str;
  Random random = new Random();
  
  Function() {
    str = genVar();
  }
  
  Function(int num) {
     this();
     iterate(num);
  }
  
  void iterate(int num) {
    for(int i = 0; i < num; i++) {
      str = str.replaceAll("[xyz]","q");
      
      while(str.contains("q")) {
        int rand = random.nextInt(4);
        if(rand == 0) {
          str = str.replaceFirst("q","sin(PI * " + genVar() + ")"); 
        } else if(rand == 1) {
          str = str.replaceFirst("q","cos(PI * " + genVar() + ")");
        } else if(rand == 2) {
          str = str.replaceFirst("q", "(" + genVar() + " + " + genVar() + ") / 2.0");
        } else {
          str = str.replaceFirst("q", genVar() + " * " + genVar()); 
        }
      }
    }
  }
  
  String getFunc() {
    return str;
  }
  
  float eval(float x, float y, float z) {
    return Float.valueOf(Solver.evaluate("x = " + x + ";y = " + y + ";z = " + z + ";" + str).toString());
  }
  
  String genVar() {
    int rand = random.nextInt(3);
    if(rand == 0) {
      return "x";
    } else if(rand == 1) {
      return "y";
    } else {
      return "z";
    }
  }
}