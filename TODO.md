# jetbrains.nvim — TODO

> Os esquemas padrão do New UI do IntelliJ (Dark e Light), com as cores tiradas do código-fonte da plataforma.

## Fidelidade
- [x] Fonte: `expUI_darkScheme.xml` (pai Darcula) e `expUI_lightScheme.xml` (pai Default) do intellij-community, com herança resolvida.
- [x] UI: rampas de cor de `expUI_{dark,light}.theme.json` (Gray, Blue, Green...): painéis, popup, seleção de lista, accent.
- [x] Cada cor da paleta comenta o atributo IntelliJ de origem.
- [x] Declaração de função azul, chamada em texto normal (Java/Kotlin/Python). `colored_calls` para o visual JS/TS.
- [x] Classes em texto normal; primitivos e `true`/`false`/`null` com a cor de keyword.
- [x] Campos roxos; constantes e membros `static` em itálico.
- [x] Estilos por variante: comentário de linha itálico só no Light; doc comment itálico nos dois; keywords nunca em negrito.
- [x] Inspeções: referência não resolvida em vermelho, código não usado em cinza, variável mutável sublinhada, `TYPO` com onda verde.
- [x] Específicos de linguagem: Python (`self`, builtins, decorators, docstrings), HTML/XML/JSX, regex, labels Kotlin, Markdown.
- [x] Teste de fidelidade com valores oficiais copiados à mão (independente da paleta).

## Paleta
- [x] Dark: `#1e1f22` / `#bcbec4`. Light: `#ffffff` / `#080808`.
- [x] Diagnósticos do Light pelas rampas do New UI (AA), em vez do `#ff0000` do esquema.
- [x] Terminal: paleta do console da IDE (`CONSOLE_*_OUTPUT`).
- [x] Relatório de contraste (`scripts/contrast.lua`), falha só abaixo de 3:1; exceções oficiais documentadas.

## Core (herdado do onemono.nvim)
- [x] Compilação para bytecode em cache, chaveado por hash da config + versão.
- [x] `jetbrains`, `jetbrains-light`, `jetbrains-dark`; troca automática via `background`.
- [x] `:JetbrainsCompile` / `:JetbrainsClearCache` / `:JetbrainsExtras`.

## Integrações
- [x] blink.cmp, mini.icons/pick/extra/files/tabline, gitsigns, dropbar, grug-far, mason, lazy.nvim, nvim-treesitter, semantic tokens.

## Extras
- [x] Ghostty, Kitty, Lazygit (light/dark) gerados da paleta.

## Documentação
- [x] README, `doc/jetbrains.txt`, banner e preview gerados da paleta.

## Ideias
- [ ] Variantes Darcula e IntelliJ Light (esquemas clássicos).
- [ ] Overrides de linguagem para Go e Rust (cores do GoLand/RustRover).
