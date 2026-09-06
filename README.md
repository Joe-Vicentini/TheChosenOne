# The Chosen One

**The Chosen One** is a Project Zomboid Build 42 mod that gives each newly created character a configurable chance of being naturally immune to the Knox infection.

## Features

- Rolls Knox immunity once when a character is created.
- Saves the immunity result in the character's mod data so it persists across saves.
- Automatically clears Knox infection for immune characters.
- Optionally allows immune characters to experience Knox fever before recovering.
- Provides sandbox settings for immunity chance, fever behavior, and the recovery-health threshold.
- Includes sandbox translations for all currently supported Project Zomboid languages.

## Sandbox Options

| Option | Default | Description |
| --- | ---: | --- |
| Immunity Chance (%) | 1% | Chance that a newly created character is naturally immune to the Knox infection. |
| Immune Players Have Knox Fever | Disabled | If enabled, immune characters experience Knox fever progression before recovering. If disabled, Knox infection is cleared immediately for immune characters. |
| Knox Fever Recovery (%) | 2% | When Knox fever is enabled, the Knox infection is cleared when its infection-driven maximum-health threshold reaches this percentage. |

## Compatibility

- **Project Zomboid:** Build 42
- **Single-player:** Supported by the current implementation.
- **Multiplayer:** Not currently supported. The immunity and infection-handling logic is client-side and has not yet been converted to a server-authoritative multiplayer implementation.

## Development Status

The mod is under active development. Features are being added incrementally, with the current focus on persistent Knox immunity and configurable fever behavior.

## License

See [LICENSE](LICENSE).
