#import "@preview/cetz:0.2.1"

#let scaleSize = 0.15  // 缩放步长
#let x0 = 4 * scaleSize // 斜边与x轴交点的x坐标
#let y0 = 3 * scaleSize // 斜边与x轴交点的y坐标
#let x1 = -2 * scaleSize // 直角边与y轴相距
#let y1 = -3 * scaleSize // 直角边与x轴相距
#let T2 = (x1, y1) // 直角点的坐标
#let T1 = (x1, y0 + 3 / 4 * calc.abs(x1)) // 上
#let T3 = (x0+4/3*calc.abs(y1), y1)   // 右下点

#let lineC(varX) = -3 / 4 * varX + y0 // 斜边表达式
#let cirPos = (3 * scaleSize, 2.7 * scaleSize) // 圆心坐标
#let y2 = lineC(cirPos.first()) // 圆心竖直线与三角形斜边的交点
#let cirR = (cirPos.last() - y2)/3 * 12/5 // 圆半径

#let lineO2(varX) = -3 / 4 * (varX - cirPos.first()) + cirPos.last() // 过圆心的斜线表达式
#let A1Pos = (0, lineO2(0)) // 过圆心的斜线与x轴的交点
#let dashLineX1 = -1 * scaleSize // 虚线的x坐标
#let dashLineX2 = 7 * scaleSize // 虚线的2坐标

#let dashLine1 = (dashLineX1, lineO2(dashLineX1)) // 虚线的起点
#let dashLine2 = (dashLineX2, lineO2(dashLineX2)) // 虚线的终点

#let fig1 = cetz.canvas(length: 1.8cm, {
  import cetz.draw: *

  set-style(
    mark: (fill: black, scale: 2),
    stroke: (thickness: 0.4pt, cap: "round"),
    content: (padding: 1pt)
  )

  // coordinate axes
  line((-1.5, 0), (1.5, 0), mark: (end: "stealth"))
  content((), $ x $, anchor: "west")
  line((0, -1.5), (0, 1.5), mark: (end: "stealth"))
  content((), $ y $, anchor: "south")

  // origin
  circle((0,0), radius: 1.5pt, fill: black)
  content((), anchor: "north-east", $O_2$)

  // Draw the triangle
  line(T1, T2, name: "a", stroke: (thickness: 0.8pt))
  line(T2, T3, name: "b", stroke: (thickness: 0.8pt))
  line(T3, T1, name: "c", stroke: (thickness: 0.8pt))

  // Draw the circle
  circle(cirPos, radius: 1.5pt, fill: black)
  circle(cirPos, radius: cirR)
  content(cirPos, anchor: "south-west", $O_1$)

  // Draw dot A
  circle(A1Pos, radius: 1.5pt, fill: black)
  content(A1Pos, anchor: "south-west", $A_1$)

  line(dashLine1, dashLine2, stroke: (dash: "dashed"))
})

#let fig2 = cetz.canvas(length: 3cm, {
  import cetz.draw: *

  // Draws an empty square with a black border
  rect((-1, -1), (1, 1))
  // Sets the global style to have a fill of red and a stroke of blue
  set-style(stroke: blue, fill: red)
  circle((0,0))
  // Draws a green line despite the global stroke is blue
  line((), (1,1), stroke: green)
})
