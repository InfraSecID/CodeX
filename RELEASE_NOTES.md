# CodeX v1.1.0 — Quality of Life Update

> Released: 2026-10-21
> Type: Minor release (backward compatible)

---

## 🎉 What's New

### 🛠️ Makefile
Shortcut command biar gak perlu ketik panjang:

| Command | Fungsi |
| --- | --- |
| `make help` | Tampilkan semua command yang tersedia |
| `make setup` | Jalankan setup lengkap (`./setup.sh`) |
| `make run` | Mulai chat dengan persona CodeX |
| `make sandbox` | Jalankan sandbox Docker tanpa internet |
| `make build-model` | Rebuild model dari `Modelfile` |
| `make clean` | Hapus image sandbox dan build artifacts |
| `make logs` | Pantau log service Ollama |
| `make test` | Tes cepat model CodeX |

### 🐳 Docker Compose
Dua service siap pakai:

- `ollama` — server Ollama dengan port `11434`, data persisten di volume `ollama_data`, dan `restart: unless-stopped`.
- `sandbox` — environment terisolasi (`network_mode: none`) dengan folder `./work` di-mount ke `/work`, aktif lewat profile `sandbox`.

Jalankan dengan `docker compose up -d`, lalu masuk ke sandbox dengan `docker compose --profile sandbox run --rm sandbox`.

### 🎨 EditorConfig
Aturan formatting konsisten untuk semua editor:

- UTF-8, LF, final newline, dan trim trailing whitespace secara default.
- Python pakai 4 spasi, shell pakai 2 spasi, PowerShell pakai CRLF.
- Markdown tidak membuang trailing whitespace (biar line break tetap aman).
- Makefile wajib pakai tab.

### ⚙️ GitHub Actions CI
Workflow `CI` otomatis jalan di setiap push dan pull request ke `main`:

- ShellCheck untuk semua script shell.
- Validasi sintaks `docker-compose.yml` dan workflow CI itu sendiri.
- Smoke test `make help`.
- Pengecekan permission executable untuk `setup.sh` dan `split.py`.

### 🪝 Pre-commit Hooks
Quality gate sebelum commit:

- Cek file besar (maksimal 500 KB), merge conflict, YAML, dan private key.
- Rapikan end-of-file dan trailing whitespace.
- Larang submodule.
- ShellCheck dengan severity `warning`.
- Black untuk semua file Python.

Aktifkan sekali dengan `pre-commit install`.

---

## 🚀 Improvements

- `.gitignore` lebih lengkap: folder `.ollama/`, `work/`, arsip `*.tgz`/`*.tar.gz`, dan backup pre-commit config sekarang diabaikan.
- `README.md` updated dengan dokumentasi command Makefile, Docker Compose, dan alur kontribusi terbaru.

---

## ⬆️ Upgrade Guide

```bash
cd ~/codex
git pull
make setup
```

Setup aman dijalankan ulang: dependency yang sudah ada akan dilewati, dan model CodeX hanya di-rebuild kalau `Modelfile` berubah.

---

## 📊 Stats

| Metric | Value |
| --- | --- |
| Files added | 6 |
| Lines added | ~150 |
| Breaking changes | None |

---

## 🔗 Full Changelog

Lihat [CHANGELOG.md](./CHANGELOG.md) atau bandingkan langsung:
https://github.com/InfraSecID/CodeX/compare/v1.0.0...v1.1.0
