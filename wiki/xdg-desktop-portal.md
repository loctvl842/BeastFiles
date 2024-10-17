## XDG Desktop Portal Setup

### Why Set Up xdg-desktop-portal?

**xdg-desktop-portal** provides integration between Flatpak apps and your desktop environment. It allows Flatpak applications to interact with native desktop features like file dialogs, notifications, and clipboard access. Setting this up ensures that applications like **Telegram** and **Postman** (installed via Flatpak) can open links, interact with files on your system, and use features such as `xdg-open` properly within your bspwm environment.

### 1. Install Required Packages

**bspwm** with **Gtk**, you'll need to install the base **xdg-desktop-portal** package and the **xdg-desktop-portal-gtk** backend for Wayland compositors.

```bash
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk
```

This setup ensures that applications running in a sandbox (like those installed via Flatpak) can interact with your Wayland session.

### 2. Configure the Service

```sh
[preferred]
default=gtk
backend=xdg-desktop-portal-gtk
```

### 3. Start and Enable the xdg-desktop-portal Service

To make sure `xdg-desktop-portal` works properly, we need to start it and ensure it runs on login. The service must run in the context of your user session, not as root.

- **Start the service**:
  ```bash
  systemctl --user start xdg-desktop-portal
  systemctl --user start xdg-desktop-portal-gtk
  ```

- **Enable the service to auto-start on login**:
  ```bash
  systemctl --user enable xdg-desktop-portal
  systemctl --user enable xdg-desktop-portal-gtk
  ```

- **Check the status of the service** to make sure it’s running correctly:
  ```bash
  systemctl --user status xdg-desktop-portal
  ```

This ensures the portal service is available when any Flatpak application requests access to system resources, such as opening files or handling URLs.

### 4. Example 
#### Telegram

To grant Telegram and Postman access to your file system and integrate them properly with **xdg-desktop-portal**, you'll need to configure them using **Flatseal**.

1. Install Flatseal:
   ```bash
   flatpak install flathub com.github.tchx84.Flatseal
   ```

2. Open **Flatseal** and configure the permissions for both Telegram and Postman:
   - **Filesystem**: Enable **All user files** to allow access to the home directory.
   - **D-Bus Session Bus**: Ensure `org.freedesktop.portal.Desktop` and `org.freedesktop.portal.FileChooser` are allowed for full integration with the desktop.

##### Testing the Setup

To verify everything is working correctly, run the following test:

```bash
xdg-open https://www.google.com
```

```bash
xdg-open "tg://resolve?domain=huggingfacepapers"
```

This command should open the URL in your default browser. If it works, applications like Telegram and Postman will be able to use `xdg-open` properly.

---

This section should help integrate your Flatpak applications with your Arch Linux bspwm environment, ensuring that `xdg-open` and other desktop features work seamlessly!

#### Postman

##### Installation

```sh
flatpak install flathub com.getpostman.Postman
```

By default, Postman will fail due to missing certificates. To fix this, follow the steps below:

- Enter shell environment of Postman via flatpak:

  ```sh
  flatpak run --command=sh com.getpostman.Postman
  ```

- Generate a new certificate:

```sh
cd ~/.var/app/com.getpostman.Postman/config/Postman/proxy
openssl req -subj '/C=US/CN=Postman Proxy' -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout postman-proxy-ca.key -out postman-proxy-ca.crt
```
