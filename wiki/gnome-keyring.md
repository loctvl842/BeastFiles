# GNOME Keyring
(ref: [GNOME/Keyring](https://wiki.archlinux.org/title/GNOME/Keyring#Resetting_the_keyring))

## Introduction

**GNOME Keyring** is a collection of tools and libraries that help manage sensitive information, such as passwords, encryption keys, and certificates, securely. It stores passwords and credentials securely in memory while providing encrypted storage for sensitive information on disk. GNOME Keyring is often used in GNOME-based environments but can also be used in other setups.

### Why do you need GNOME Keyring when you already have passwordstore?

While `passwordstore` (pass) is a secure and lightweight password manager that stores passwords in GPG-encrypted files and allows you to retrieve them from the command line, **GNOME Keyring** serves a different purpose in many cases:

1. **Automatic Unlocking**: GNOME Keyring integrates deeply with system components to automatically unlock your credentials at login.
2. **Service Integration**: Some applications or services (e.g., browsers, email clients, VPNs) integrate with GNOME Keyring to store their credentials or encryption keys. For example, the Brave browser might use GNOME Keyring to store website credentials or session tokens.
3. **GUI Integration**: For users who prefer graphical management of their passwords and keys, GNOME Keyring provides tools like `seahorse` for a more visual interface.
4. **Session Management**: GNOME Keyring provides session management capabilities, helping to ensure your keys are only unlocked for the duration of your session.

## Set up GNOME Keyring on Arch Linux with bspwm

1. **Install GNOME Keyring**: Open a terminal and install the `gnome-keyring` package:

```sh
sudo pacman -S gnome-keyring
```

2. **Enable GNOME Keyring Daemon**: You need to add the GNOME Keyring components to your session. Since you're using `bspwm`, you can add the following to your `~/.xinitrc` or bspwm startup file
(`config/bspwm/bspwmrc`):

```sh
dbus-update-activation-environment --all

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)\
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID\
export SSH_AUTH_SOCK\
```

3. **Install Seahorse (optional)**: Seahorse is a graphical frontend for GNOME Keyring, useful for managing passwords and keys visually:

```sh
sudo pacman -S seahorse
```

4. **Configure Applications**: Many applications, such as browsers (Brave, Chromium, etc.) and mail clients, will automatically detect and use GNOME Keyring for storing passwords.

5. **Manage SSH and GPG Keys**: GNOME Keyring can manage your SSH and GPG keys. Ensure that the daemon is started with the appropriate components (ssh and gpg as shown in step 2).

6. **Enable GNOME Keyring to work with applications installed via Flatpak (like Postman) in non-GNOME desktop environments (such as `bspwm`)

- Edit file `/usr/share/xdg-desktop-portal/portals/gnome-keyring.portal`

```
[portal]
DBusName=org.freedesktop.secrets
Interfaces=org.freedesktop.impl.portal.Secret
UseIn=gnome;bspwm
```

**NOTE**: Add `bspwm` to the list of desktop environments to use GNOME Keyring, the modified line should look like this:

```
UseIn=gnome;bspwm
```

- Restart xdg-desktop-portal service:

## How Gnome Keyring Works

```sh
systemctl --user restart xdg-desktop-portal
```

- GNOME Keyring is a **password and encryption key** management system that stores sensitive information, such as passwords, credentials, and encryption keys. This information is stored in a secure manner, typically encrypted using a **master password** (often called the keyring password). When you log into your system, GNOME Keyring expects to be unlocked so it can provide access to these stored credentials.

- GNOME Keyring locks itself automatically for security purposes. Upon starting your session, the keyring remains locked until you explicitly unlock it by entering its **passphrase**.

### How PAM (Pluggable Authentication Modules) Helps

PAM allows the system to perform tasks such as authenticating the user and handling login processes, including unlocking GNOME Keyring. Here's how it works with GNOME Keyring:

1. **Auto Unlock on Login**:

- When PAM is configured correctly, it can instruct GNOME Keyring to unlock using the same password you use to log in. The keyring password is set to be the same as your login password, so when you authenticate yourself at login, PAM unlocks the keyring in the background.
- This prevents the need for manually entering the keyring passphrase after logging in.

2. **PAM Configuration**:

- PAM needs to be configured in certain system files (like `/etc/pam.d/login` or `/etc/pam.d/lightdm` depending on how you log in). These configuration files tell the system to **unlock the keyring** when you log in.

```pamconf
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
```
