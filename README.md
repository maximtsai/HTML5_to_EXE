# Phaser 3 Game → Windows EXE

Convert your HTML5 Phaser 3 game into a portable Windows `.exe`.

## Prerequisites (one-time setup)

1. **Node.js** — [nodejs.org](https://nodejs.org) (v18+)
2. **Rust** — run `winget install Rustlang.Rustup` in PowerShell, then restart your terminal
3. **Visual Studio Build Tools** — with "Desktop development with C++" workload

## Usage

### 1. Add your game

Drop your Phaser 3 game files into the `game/` folder. Your `index.html` must be directly inside `game/` (not in a subfolder).

```
game/
├── index.html        ← required
├── assets/           
├── js/
│   ├── phaser.min.js ← bundle Phaser locally, don't use CDN
│   └── game.js
└── css/
    └── style.css
```

> **Important:** Include `phaser.min.js` locally in your game files. CDN links won't work in the packaged EXE since it runs offline.

### 2. Add your icon (optional)

Place your game icon as `ico/icon.ico` (256×256 recommended).

### 3. Build

Double-click `build.bat` or run it from a terminal:

```
build.bat
```

The first build takes a few minutes (compiling Rust). Subsequent builds are much faster.

### 4. Get your EXE

After building, your EXE is at:
```
src-tauri/target/release/Game.exe
```

An NSIS installer is also generated at:
```
src-tauri/target/release/bundle/nsis/
```

## Customization

Edit `src-tauri/tauri.conf.json` to change:
- **Window title**: `app.windows[0].title`
- **Window size**: `app.windows[0].width` / `height`
- **EXE name**: `productName`
- **App identifier**: `identifier`

## Project Structure

```
├── game/               ← Drop your Phaser 3 game here
├── ico/                ← Drop your icon.ico here  
├── src-tauri/          ← Tauri config (don't need to edit usually)
│   ├── tauri.conf.json ← Main config file
│   ├── Cargo.toml
│   ├── src/main.rs
│   └── icons/
├── build.bat           ← Run this to build the EXE
├── package.json
└── README.md
```
