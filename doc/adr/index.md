# ODRA Architecture Decision Records

[![Architecture Decision Records](/doc/adr/graph.jpg "Architecture Decision Records Graph")](/doc/adr/toc.md)

[Show Table Of Content](/doc/adr/toc.md)

To manage application architecture decisions we use [adr-tools](https://github.com/npryce/adr-tools).

1. To instal on macOS run `brew install adr-tools`. Check [here](https://github.com/npryce/adr-tools/blob/master/INSTALL.md) for other OS.

2. To create new record run i.e: `adr new Add History Tab`.
   *This will create a new, numbered ADR file in `doc/adr/` directory*

3. Open created file, describe record **context**, **decision** that was made and possible **consequeces**.

4. Run `adr generate toc > doc/adr/toc.md` to create/update [Table of Content](/doc/adr/toc.md)

5. Run `adr generate graph | dot -Tjpg > doc/adr/graph.jpg` to create [graph.jpg](/doc/adr/graph.jpg) image of decision records
   *You might need to install [Graphviz - Graph Visualization Software](https://graphviz.org/download/) to generate image.*
