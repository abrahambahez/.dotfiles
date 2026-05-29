# Fedora + Dank Linux (Hyprland) — Instalación desde cero

## Prerequisitos

- ISO: Fedora Everything (netinstall) — [descargar aquí](https://fedoraproject.org/everything/)
- Mínimo 4 GB RAM, 10 GB almacenamiento
- Procesador de los últimos 10 años
- Conexión a internet (cable o USB tethering)

---

## 1. Instalar Fedora sin entorno de escritorio

1. Grabar la ISO en un USB y arrancar desde él
2. En el instalador de Anaconda:
   - Crear usuario con contraseña (no es necesario crear cuenta root, `sudo` es suficiente)
   - Conectar a WiFi si es posible en esta etapa
   - En la selección de software: **deseleccionar todo**
3. Completar la instalación y reiniciar
4. Iniciar sesión en la terminal (CLI)

---

## 2. Conectar a internet

**Cable Ethernet:** detectado automáticamente por NetworkManager.

**USB tethering:**
```bash
nmcli device status
nmcli device connect <iface>
```

**WiFi:**
```bash
nmcli device wifi list
nmcli device wifi connect "SSID" password "contraseña"
```

---

## 3. Instalar Dank Linux

El instalador maneja automáticamente el COPR de Hyprland, los paquetes necesarios y permite elegir compositor y emulador de terminal:

```bash
curl -fsSL https://install.danklinux.com | sh
```

Configura:
- **DankMaterialShell** (entorno de escritorio)
- **dgop**, **dsearch**, **matugen**
- Compositor (Hyprland) y emulador de terminal (Ghostty, Kitty, Alacritty)

---

## 4. Activar el display manager y entorno gráfico

```bash
sudo systemctl enable sddm.service
sudo systemctl set-default graphical.target
reboot
```

---

## 5. Instalar dotfiles y software personal

Desde una terminal, clonar los dotfiles y correr el script de postinstalación:

```bash
git clone <repo> ~/.dotfiles
cd ~/.dotfiles/postinstall/linux
bash dank.sh
```

Instala: paquetes DNF (zsh, neovim, rofi…), COPR (ghostty, espanso), Flatpaks (Zotero, Spotify, Zen…), fuentes y configura zsh, uv y Homebrew.

## 6. Opcional — Software adicional

**Fondo de pantalla:**
```bash
sudo dnf install azote swaybg
```

**Ofimática y multimedia:**
```bash
sudo dnf install gimp vlc firefox libreoffice thunderbird
```

**Utilidades:**
```bash
sudo dnf install flameshot grim simple-scan nwg-look
```

---

## Solución de problemas

### Waybar o el agente de autenticación no inician al abrir sesión

Editar la configuración de Hyprland:

```bash
vi ~/.config/hypr/hyprland.conf
```

Agregar en la sección `exec-once`:

```conf
exec-once = waybar
exec-once = systemctl --user start hyprpolkitagent
```

---

## Referencias

- [Dank Linux — Getting Started](https://danklinux.com/docs/getting-started)
- [Tutorial Fedora 43 + Hyprland desde cero](https://discussion.fedoraproject.org/t/tutorial-fedora-43-install-hyprland-from-scratch/168386)
- [Hyprland Wiki — Configuración de monitores y teclado](https://wiki.hyprland.org)
