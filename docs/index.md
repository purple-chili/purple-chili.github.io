# Chili

**chili** is a data analytics and engineering engine powered by [Polars](https://pola.rs/). It ships as a single distribution with two syntax modes:

- `chili` uses a modern syntax with query language similar to `javascript`.
- `pepper` uses a vintage syntax with query language similar to `q`.

## Demo

<video src="assets/demo.mp4" width="906" height="756" controls></video>

## Installation

Support Linux (x86_64 and aarch64), macOS, and Windows (x86_64).

Install from [chili-pie](https://pypi.org/project/chili-pie/) with `uv` or `pip`:

```sh
uv pip install -U chili-pie
```

```sh
pip install -U chili-pie
```

Run with chili syntax:

```sh
chili
```

Run with pepper syntax:

```sh
chili --pepper
# or
chili -P
```

---

## Editor & Tooling

### Companion Tool `chiz`

Install from [PyPI](https://pypi.org/project/chiz/), using `uv` or `pip`:

```sh
uv pip install -U chiz
```

```sh
pip install -U chiz
```

With `chiz`, you can:

- `chiz fmt` to format code
- `chiz serve` to start a language server
- `chiz parse` to parse code, and check syntax errors
- `chiz vim` to install <span style="color:lime; font-weight: bold;">vim</span> syntaxes

### VSCode Extension

Install from [VSCode Marketplace](https://marketplace.visualstudio.com/items?itemName=jshinonome.vscode-chili), this extension requires `chiz` to be installed for providing language server features.

### Neovim Plugin

Install from [chili-neovim](https://github.com/jshinonome/chili-neovim), using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "jshinonome/chili-neovim",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
  },
  config = function()
    require("chili").setup()
  end,
}
```

## Change Log

refer to [Change Log](https://github.com/purple-chili/chili/blob/main/CHANGELOG.md) for the latest updates.

[Command Line]: cmd-line.md
[Syntax]: syntax.md
[Data Types]: data-types.md
[Operators]: op.md
[Partitioned DataFrame]: partitioned-df.md
[Query]: query.md
[Environment Variables]: env.md
[Data Flow]: data-flow.md
[Basic]: built-in-functions/basic.md
[Config]: built-in-functions/config.md
[DataFrame]: built-in-functions/df.md
[Dictionary]: built-in-functions/dict.md
[IO]: built-in-functions/io.md
[IPC]: built-in-functions/ipc.md
[Job Scheduler]: built-in-functions/job.md
[Log]: built-in-functions/log.md
[Math]: built-in-functions/math.md
[Matrix]: built-in-functions/matrix.md
[Message Broker]: built-in-functions/broker.md
[OS]: built-in-functions/os.md
[Series]: built-in-functions/series.md
[String]: built-in-functions/str.md
[Temporal]: built-in-functions/temporal.md
[Test]: built-in-functions/test.md
[Real-time case]: cookbook/real-time-case.md
