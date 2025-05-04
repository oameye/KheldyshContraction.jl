using TikzPictures

options = "scale=1, background rectangle/.style={fill=white}, show background rectangle"
preamble="\\usetikzlibrary{backgrounds}\n\\usepackage{tikz-feynman}"

figure = """
  \\begin{feynman}
    \\vertex (a) {\\(x_1\\)};
    \\vertex [right=of a] (b);
    \\vertex [right=of b] (c) {\\(x_2\\)};

    \\diagram* {
      (a) -- [scalar] (b) [dot] -- [out=125, in=55, loop, min distance=2cm] b -- [anti fermion] (c)
    };
  \\end{feynman}
"""

TikzPicture(figure; options, preamble,  height="10cm")
