class MenuElement
{
  int x;
  int y;
  int w;
  int h;

  String msg;
  int value;
  int mines;

  MenuElement(int x, int y, int w, int h, String msg, int value, int mines)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.msg   = msg;
    this.value = value;
    this.mines = mines;
  }

  void show()
  {
    stroke(1);
    textAlign(CENTER, CENTER);
    fill(0, 0, 0);
    textSize(22);
    text(msg, x+w/2, y+h/2);
    noFill();
    rect(x, y, w, h);
  }

  boolean clicked()
  {
    if (mousePressed)
      if (mouseX < x+w && mouseX > x && mouseY < y+h && mouseY > y)
      {
        return true;
      }
    return false;
  }
}
