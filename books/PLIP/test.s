Compiled from "test.java"
class Point {
  int x;

  int y;

  Point();
    Code:
       0: aload_0
       1: invokespecial #1                  // Method java/lang/Object."<init>":()V
       4: return

  void setX(int);
    Code:
       0: aload_0
       1: aload_0
       2: getfield      #2                  // Field x:I
       5: putfield      #2                  // Field x:I
       8: return

  void setY(int);
    Code:
       0: aload_0
       1: iload_1
       2: putfield      #3                  // Field y:I
       5: return
}