# @asm80/cli

Příkazové nástroje ASM80 – assembler, linker, archivátor knihoven a emulátor pro 8bitové procesory.

| Příkaz | Popis |
| --- | --- |
| `asm80` | přeloží zdrojový soubor (`.z80`, `.a80`, `.a65`, …) na `.hex`/`.srec` (+ listing), nebo s `--module` na relokovatelný objekt |
| `asm80-link` | slinkuje moduly podle receptu `.lnk` |
| `asm80-ar` | sestaví knihovnu podle receptu `.lbr` |
| `asm80-run` | přeloží/načte program a spustí ho v emulátoru |

## Instalace

```sh
npm i -g @asm80/cli
```

Vyžaduje Node.js 22 nebo novější (CI testuje Node 22 a 24). Samostatné binárky (bez nutnosti instalovat Node.js, obsahují vestavěný Node.js 24) pro Windows, Linux a macOS jsou přiložené ke [GitHub Releases](https://github.com/asm80/asm80-cli/releases).

## Použití

```sh
asm80 program.z80          # vytvoří program.hex a program.lst
asm80 --module lib.z80     # relokovatelný objekt
asm80-link app.lnk
asm80-ar mylib.lbr
asm80-run program.z80
```

Všechny příkazy vypíšou nápovědu přes `--help`.

## O tomto repozitáři

Soubory `asm80.js`, `asm80-link.js`, `asm80-ar.js` a `asm80-run.js` jsou **obfuskované bundly** vygenerované z projektu ASM80 (sestavení probíhá v [asm80/IDEv2](https://github.com/asm80/IDEv2) z [asm80/asm80-core](https://github.com/asm80/asm80-core) a [asm80/emu](https://github.com/asm80/emu)); zdrojový kód zde proto není čitelný. Repozitář slouží k publikaci na npm a ke sestavení samostatných binárek (`@yao-pkg/pkg`) při vydání (tag `v*`).

Před každým vydáním (a v CI) běží smoke test `scripts/smoke.sh`: přeloží ukázkový zdroj a ověří, že všechny čtyři nástroje jdou spustit; po sestavení se stejným způsobem otestuje linuxová binárka. Lokálně: `npm test`.
