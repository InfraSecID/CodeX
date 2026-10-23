# CodeX — Offline AI Coding Assistant

![CI](https://github.com/InfraSecID/CodeX/actions/workflows/ci.yml/badge.svg)
![GitHub release](https://img.shields.io/github/v/release/InfraSecID/CodeX?style=flat-square)
![GitHub stars](https://img.shields.io/github/stars/InfraSecID/CodeX?style=flat-square)
![License](https://img.shields.io/github/license/InfraSecID/CodeX?style=flat-square)

> Local, offline AI coding assistant powered by **Ollama + DeepSeek + Docker sandbox**.
> No API keys, no cloud, full control on your own machine.
>
> **Hybrid mode (v1.2.0+):** optionally add Google Antigravity for cloud models.
>
> Yeah, it runs on your own PC. Your GPU is crying, but your privacy is smiling. 😎

---

## ✨ Features

- 🧠 **Runs fully offline** — no internet after setup
- 💻 **Cross-platform** — Windows, Linux, macOS, Termux (Android)
- 🔄 **Multi-model support** — DeepSeek, Qwen, CodeLlama (v1.2.0+)
- 🌐 **Hybrid mode** — add Antigravity cloud models (v1.2.0+)
- 🛡️ **Docker sandbox** — safe code testing
- 🎭 **Custom persona** — CodeX, direct & no-nonsense
- 🎨 **CLI banner** — figlet + lolcat (v1.2.0+)
- 📚 **Full docs** — install guides, troubleshooting, FAQ
- 🔌 **OpenAI-compatible** — works with OpenCode, LM Studio, etc.

---

## 📋 Requirements

| Platform | RAM | Disk | Notes |
|----------|-----|------|-------|
| **Windows** | 8 GB+ | 5 GB | Use `setup.ps1` |
| **Linux** | 8 GB+ | 5 GB | Use `setup.sh` |
| **macOS** | 8 GB+ | 5 GB | Use `setup.sh` |
| **Termux** | 6 GB+ | 3 GB | Small models only, no Docker |

### Model sizes

| Model | Size | RAM needed | Best for |
|-------|------|------------|----------|
| `deepseek-coder:6.7b` | 4 GB | 8 GB+ | Best quality |
| `qwen2.5-coder:1.5b` | 1 GB | 4 GB+ | Low-RAM devices |
| `codellama:7b` | 4 GB | 8 GB+ | Alternative |

> ⚠️ `deepseek-coder:6.7b` needs ~4 GB disk and **8 GB RAM minimum**.
> For low-end devices, use `qwen2.5-coder:1.5b`. Your toaster will thank you.

---

## 🚀 Quick Start

### 🪟 Windows

```powershell
winget install Ollama.Ollama
ollama pull deepseek-coder:6.7b
git clone https://github.com/InfraSecID/CodeX.git
cd CodeX
Set-ExecutionPolicy -Scope Process Bypass
.\setup.ps1
ollama run codex
```

Docker sandbox:

```powershell
docker build -t sandbox .
docker run -it --rm --network none -v ${PWD}:/work sandbox
```

### 🐧 Linux / 🍎 macOS

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull deepseek-coder:6.7b
git clone https://github.com/InfraSecID/CodeX.git
cd CodeX
chmod +x setup.sh
./setup.sh
ollama run codex
```

Docker sandbox:

```bash
docker build -t sandbox .
docker run -it --rm --network none -v $(pwd):/work sandbox
```

### 📱 Termux (Android)

> ⚠️ Termux **cannot run Docker natively**. Use the Ollama Termux fork with a small model.

```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts -y
npm install -g @mmmbuto/ollama-termux@latest
ollama-termux serve &
ollama-termux pull qwen2.5-coder:1.5b
ollama-termux run qwen2.5-coder:1.5b
```

**Note:** For Termux, use small models (`1.3b`–`1.5b`). Docker sandbox is **not available** — test code on a PC instead.

---

## 🔄 Multi-Model Support (v1.2.0+)

CodeX now supports multiple models. Switch anytime:

```bash
./switch-model.sh qwen-1.5b
```

### Benchmark models

```bash
./benchmark.sh
```

### Add new model

1. Create `models/your-model.Modelfile`
2. Run `./switch-model.sh your-model`
3. Update OpenCode config with `codex-your-model`

---

## 🌐 Hybrid Mode — Antigravity Cloud (v1.2.0+)

Add **Google Antigravity** as cloud provider (optional, needs internet + Google account):

```bash
./setup-antigravity.sh
opencode auth login
```

Then in OpenCode:
- `/model` → pick `ollama/codex` (local, offline)
- `/model` → pick `antigravity/gemini-3-pro` (cloud, online)

### Local vs Cloud

| Provider | Models | Connection | Use when |
|----------|--------|------------|----------|
| **Ollama** | codex, deepseek, qwen | **Offline** 🔒 | Privacy, no internet |
| **Antigravity** | gemini, claude | **Online** 🌐 | Complex tasks, bigger models |

> ⚠️ Antigravity is **unofficial plugin** (`opencode-antigravity-auth`). Use only in trusted workspaces.

---

## 🎨 CLI Banner (v1.2.0+)

Run CodeX with a figlet banner:

```bash
./codex-cli.sh
```

Output:
```
  ____          _  __  __
 / ___|___   __| | \ \/ /
| |   / _ \ / _` |  \  /
| |__| (_) | (_| |  /  \
 \____\___/ \__,_| /_/\_\

  🤖 Offline AI Coding Assistant
  📡 Model: codex
  🛡️  Sandbox: docker run ...
  🌐 Hybrid: use Antigravity for cloud models
```

Install dependencies:
```bash
sudo apt install figlet lolcat
```

---

## 🛠️ Makefile Shortcuts

| Command | What it does |
|---------|--------------|
| `make setup` | Full setup (Ollama + model + persona + sandbox) |
| `make run` | Chat with CodeX persona |
| `make sandbox` | Start Docker sandbox (no internet) |
| `make build-model` | Rebuild CodeX persona from Modelfile |
| `make test` | Quick sanity test |
| `make clean` | Remove build artifacts |
| `make help` | Show all commands |

Example:
```bash
make setup
make run
```

---

## 🐳 Docker Compose

Run Ollama as a container:

```bash
docker compose up -d
```

Run sandbox with compose:

```bash
docker compose --profile sandbox run sandbox
```

Stop everything:

```bash
docker compose down
```

---

## 🤖 CI/CD

Every push to `main` triggers:
- ShellCheck lint
- YAML validation
- Makefile validation
- Executable permission check

See [`.github/workflows/ci.yml`](.github/workflows/ci.yml) for details.

---

## 🔒 Pre-commit Hooks

Install once:
```bash
pip install pre-commit
pre-commit install
```

Every `git commit` auto-checks:
- Large files
- Private keys
- Merge conflicts
- YAML validity
- Shell script lint

---

## 📚 Documentation

Full guides available in [`docs/`](docs/):

| Guide | Description |
|-------|-------------|
| [Install on Windows](docs/install-windows.md) | Windows setup guide |
| [Install on Linux](docs/install-linux.md) | Linux setup guide |
| [Install on Termux](docs/install-termux.md) | Android/Termux guide |
| [Troubleshooting](docs/troubleshooting.md) | Common issues & fixes |
| [FAQ](docs/FAQ.md) | Frequently asked questions |

---

## 📁 Repository Structure

```
codex/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── CONTRIBUTING.md
├── RELEASE_NOTES.md
├── Makefile
├── docker-compose.yml
├── Dockerfile
├── Modelfile
├── setup.sh
├── setup.ps1
├── setup-antigravity.sh
├── switch-model.sh
├── benchmark.sh
├── codex-cli.sh
├── split.py
├── models/
│   ├── deepseek-6.7b.Modelfile
│   ├── qwen-1.5b.Modelfile
│   └── codellama-7b.Modelfile
├── docs/
│   ├── install-windows.md
│   ├── install-linux.md
│   ├── install-termux.md
│   ├── troubleshooting.md
│   └── FAQ.md
└── .github/
    └── workflows/
        └── ci.yml
```

---

## 🐛 Troubleshooting

| Problem | Fix |
|---------|-----|
| `ollama: command not found` | Reinstall, restart terminal |
| Model very slow | RAM too low — use `./switch-model.sh qwen-1.5b` |
| OpenCode not connecting | Check `curl http://localhost:11434/v1/models` |
| Docker permission denied (Linux) | `sudo usermod -aG docker $USER`, then re-login |
| Docker can't mount folder (Windows) | Enable drive sharing in Docker Desktop settings |
| Termux: model too heavy | Use `qwen2.5-coder:1.5b` or smaller |
| `switch-model.sh` permission denied | `chmod +x switch-model.sh benchmark.sh codex-cli.sh setup-antigravity.sh` |
| `figlet: command not found` | `sudo apt install figlet` (Linux) or `brew install figlet` (macOS) |
| Model not found | `ollama pull deepseek-coder:6.7b` |
| Out of memory | Use smaller model, close other apps, increase swap |
| `make help` fails | Makefile uses tabs, not spaces |
| CI fails on ShellCheck | Add `severity: 'error'` to action config |
| `YAML invalid` | `python3 -c "import yaml; yaml.safe_load(open('docker-compose.yml'))"` |
| `setup.sh not executable` | `chmod +x setup.sh split.py` |
| Docker image not built | `docker build -t sandbox .` |
| Antigravity auth fails | `opencode auth login` again, check Google account |
| Antigravity not showing in `/model` | Restart OpenCode after `setup-antigravity.sh` |

For more, see [docs/troubleshooting.md](docs/troubleshooting.md).

---

## 🔗 Links

- [Changelog](CHANGELOG.md)
- [Release Notes](RELEASE_NOTES.md)
- [Contributing](CONTRIBUTING.md)
- [Issues](https://github.com/InfraSecID/CodeX/issues)
- [Discussions](https://github.com/InfraSecID/CodeX/discussions)
- [Releases](https://github.com/InfraSecID/CodeX/releases)

---

## ⚠️ Disclaimer

This project is for **educational and research purposes**.
Always test untrusted code inside the Docker sandbox.
Antigravity plugin is **unofficial** — use at your own risk.
The author is not responsible for misuse. Don't be that guy. Seriously.

---

## 📄 License

MIT — see [LICENSE](LICENSE) for details.

---

**Version:** 1.2.0
**Last updated:** 2026-10-21
**Made with:** ☕ + 🧠 + a GPU that's probably crying right now
**Special thanks:** to everyone who reads documentation. You're the real MVP. 🏆
