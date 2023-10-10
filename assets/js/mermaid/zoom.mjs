import { BtnSummary } from "./summary.mjs";

export function zoom(elem, svg) {
  const summary = BtnSummary(elem);
  // const figure = document.createElement("figure");
  // figure.appendChild(elem.cloneNode(true));
  // figure.appendChild(summary);
  // elem.parentNode.replaceChild(figure, elem);
  elem.parentNode.insertBefore(summary, elem);
  // elem.appendChild(summary);

  // const panzoom = Panzoom(svg, { noBind: true, cursor: "arrow" });
  // const menu = Menu(panzoom);
  // elem.appendChild(menu);
}
