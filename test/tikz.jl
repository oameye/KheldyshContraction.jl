using TikzPictures

options = "scale=1, background rectangle/.style={fill=white}, show background rectangle"
preamble="\\usetikzlibrary{backgrounds}\n\\usepackage{tikz-feynman}"

figure = """
  \\begin{feynman}
    \\vertex (a) {\\(\\mu^{-}\\)};
    \\vertex [right=of a] (b);
    \\vertex [above right=of b] (f1) {\\(\\nu_{\\mu}\\)};
    \\vertex [below right=of b] (c);
    \\vertex [above right=of c] (f2) {\\(\\overline \\nu_{e}\\)};
    \\vertex [below right=of c] (f3) {\\(e^{-}\\)};

    \\diagram* {
      (a) -- [fermion] (b) -- [fermion] (f1),
      (b) -- [boson, edge label'=\\(W^{-}\\)] (c),
      (c) -- [anti fermion] (f2),
      (c) -- [fermion] (f3),
    };
  \\end{feynman}
"""

TikzPicture(figure; options, preamble,  height="10cm")
