# Script MT installer

## ⚙️ Установка на сервере (всё тянется с GitHub)

### ❓ Интерактивно - с запросом порта и домена
```bash
bash <(curl -Ls https://raw.githubusercontent.com/SibMan54/script-mt-installer/refs/heads/main/install.sh)
```
### ✅ Неинтерактивно - автоустановка
```bash
curl -sSL https://raw.githubusercontent.com/SibMan54/script-mt-installer/refs/heads/main/install.sh | bash
```

## ❌ Удаление

### ❓ С запросом
```bash
bash <(curl -Ls https://raw.githubusercontent.com/SibMan54/script-mt-installer/refs/heads/main/uninstall.sh)
```
### ✅ Без запроса
```bash
curl -sSL https://raw.githubusercontent.com/SibMan54/script-mt-installer/refs/heads/main/uninstall.sh | bash
```