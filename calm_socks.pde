float zoom = 0;
int MAX_ZOOM_IN = 200, MAX_ZOOM_OUT = -200;
final ArrayList<Star> stars = new ArrayList<>();
final int WIDTH = 1000, HEIGHT = 800, DEPTH = 1000;
final int MAX_STARS = 100;

void setup() {
    size(1000, 800, P3D);
    textSize(20);
  
    addnames();
    generate_stars();
    noCursor();
}

void draw() {
  background(0);
  float mX = mouseX;
  float mY = mouseY;
  float mZ = (height/2) / tan(PI/6) - zoom;
  camera(mX, mY, mZ, 
          mX, mY, 0, 
          0, 1, 0);
          
  draw_text();
  
  translate(width/2, height/2, -100);
  
  draw_stars();

  
  if (keyPressed) {
      if (key == 'a' && zoom < MAX_ZOOM_IN) {
          zoom += 10;
      } else if (key == 'z' && zoom > MAX_ZOOM_OUT) {
          zoom -= 10;
      }
  }
}

void generate_stars() {
    
    for (int i=0; i < MAX_STARS; i++) {
        stars.add(new Star( starSystems.get(i % starSystems.size()) ));
    }
    
}

void addnames() {
    for (String name : starnames) {
        starSystems.add(name);
    }
}

void draw_text() {
    noFill();
    stroke(255);
    ellipse(mouseX, mouseY, 10, 10);
    for (Star star : stars) {
        if (dist(star.getLoc().x, star.getLoc().y, mouseX, mouseY) < star.getSize() ) {
            text(star.getName(), mouseX + 10, mouseY + 10);
        }
    }
    
}

void draw_stars() {
    fill(255);
    stroke(0);
    for (Star star : stars) {
        pushMatrix();
        //translate(star.getLoc().x, star.getLoc().y, star.getLoc().z);
        translate(-WIDTH / 2, -HEIGHT / 2,star.getLoc().z);
        //ellipse(0,0,star.getSize(), star.getSize());
        
        //fill(255, 255 * (0.5), 255 * (0.5));
        ellipse(star.getLoc().x, star.getLoc().y, star.getSize(), star.getSize());
        
        popMatrix();
    }
    
}
