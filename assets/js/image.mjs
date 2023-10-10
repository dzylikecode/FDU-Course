import mediumZoom from "https://unpkg.com/medium-zoom@1.0.8/dist/medium-zoom.esm.js";
import { docsifyPlugins } from "./config.mjs";
import { zoom as zoomSvg } from "./mermaid/zoom.mjs";

function install(hook) {
  let zoom;

  hook.doneEach((_) => {
    let elms = Array.from(
      document.querySelectorAll(
        ".markdown-section img:not(.emoji):not([data-no-zoom])"
      )
    );

    elms = elms.filter((elm) => !elm.matches("a img"));

    const { normalImages, drawioImages } = elms.reduce(
      (acc, elm) => {
        const src = elm.getAttribute("src");
        if (src.endsWith(".drawio.svg")) {
          acc.drawioImages.push(elm);
        } else {
          acc.normalImages.push(elm);
        }
        return acc;
      },
      { normalImages: [], drawioImages: [] }
    );

    if (zoom) {
      zoom.detach();
    }

    zoom = mediumZoom(elms);

    drawioImages.forEach(async (elm) => {
      const src = elm.getAttribute("src");
      const res = await fetch(src);
      const svgText = await res.text();
      elm.dataset.content = svgText;
      zoomSvg(elm);
    });
  });
}

docsifyPlugins.push(install);
