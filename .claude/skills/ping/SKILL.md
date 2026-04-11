---
name: ping
description: Control peon-ping voice packs — check, list, or switch the current voice
usage: /ping [current|list|listall|<voice>]
examples:
  - /ping current
  - /ping list
  - /ping listall
  - /ping glados
  - /ping bells
allowed-tools:
  - Bash(peon:*)
---

# Ping — Peon-Ping Voice Control

Friendly wrapper around `peon` CLI for managing voice packs.

## Voice Aliases

Map short names to full pack names before running any command:

| Alias | Pack Name |
|-------|-----------|
| 2001 | hal_2001 |
| bender | futurama_bender |
| bells | clean_chimes |
| chimes | clean_chimes |
| blues | blues_brothers_jake |
| battlecruiser | sc_battlecruiser |
| diehard | diehard |
| dude | lebowski_the_dude |
| gilfoyle | gilfoyle |
| glados | glados |
| kerrigan | sc_kerrigan |
| lumbergh | office_space_lumbergh |
| meeseeks | openpeon_mrmeeseeks |
| officespace | office_space |
| omar | omar |
| peasant | peasant |
| peon | peon |
| peter | office_space_peter |
| sopranos | sopranos |

## Commands

### `/ping current`
Show which voice pack is active:
```bash
peon packs list | grep -E '^\*'
```
Report just the voice name to the user.

### `/ping list`
List installed voice packs:
```bash
peon packs list
```
Show results using the short alias names from the table above.

### `/ping listall`
List all available voice packs (installed and not):
```bash
peon packs list --registry
```
Show the full list. Note which ones are already installed.

### `/ping <voice>`
Switch to a voice. Resolve the alias from the table above, then:
```bash
peon packs use <full-pack-name>
```
If the pack isn't installed, install and switch:
```bash
peon packs use --install <full-pack-name>
```
Confirm the switch to the user.

If the alias isn't in the table, try using it as a literal pack name. If that fails, search the registry:
```bash
peon packs list --registry | grep -i <voice>
```
Suggest matches if found.
