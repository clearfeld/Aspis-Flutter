# Aspis

Aspis is a free, secure, and open source 2FA app targeting all major platforms, check the table below for current platform support.

| Android            | iOS       | Windows             | MacOS               | Linux               | Web |
|--------------------|-----------|---------------------|---------------------|---------------------|-----|
| :heavy_check_mark: | Planned   | :heavy_check_mark:* | :heavy_check_mark:* | :heavy_check_mark:* | ✖️ |

## Screenshots

<img src="https://user-images.githubusercontent.com/49600278/250694714-83e20662-140b-4d51-a7f0-4f643a3ee7aa.png" 
alt="Screenshot-1-Dark" width="200"/>
<img src="https://user-images.githubusercontent.com/49600278/250694717-33f4f1ca-3fd8-4b36-b1d5-7883f345c80c.png" 
alt="Screenshot-2-Dark" width="200"/>
<img src="https://user-images.githubusercontent.com/49600278/250694716-253c8dba-b602-4a0a-87b6-f465a5f6ca04.png" 
alt="Screenshot-1-Light" width="200"/>
<img src="https://user-images.githubusercontent.com/49600278/250694715-88c68469-5bfb-45a3-bd07-d860af8a8631.png" 
alt="Screenshot-2-Light" width="200"/>

## Features

* Free and open source
* Secure
  * Password required (Encrypted realm db vault)
* Supports HTOP and TOTP codes
* Add QR Codes
  * Scan QR codes (mobile systems only)
  * Manual entry
* Dark and light themes

## Getting Started
### Realm

Must run the following command, when new realm models are added or modified.

```bash
flutter pub run realm generate
```

### i18n

Must run the following command, when new translations are added.

```bash
flutter gen-l10n
```
