#!/usr/bin/env bash
set -e

INSTALL_DIR="${INSTALL_DIR:-$(pwd)/mtproxy-data}"
FORCE=

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
err()   { echo -e "${RED}[ERR]${NC} $*"; exit 1; }

while [[ $# -gt 0 ]]; do
	case "$1" in
		-y|--yes) FORCE=1; shift ;;
		-h|--help)
			echo "Использование: $0 [-y|--yes] [каталог]"
			echo "  Останавливает контейнеры и удаляет каталог установки MTProxy."
			echo "  Каталог: по умолчанию $(pwd)/mtproxy-data"
			echo "  -y, --yes  без подтверждения"
			exit 0
			;;
		*)
			INSTALL_DIR="$1"
			shift
			break
			;;
	esac
done

[[ "${INSTALL_DIR}" != /* ]] && INSTALL_DIR="$(pwd)/${INSTALL_DIR}"

if [[ ! -d "$INSTALL_DIR" ]]; then
	err "Каталог не найден: ${INSTALL_DIR}"
fi

if [[ ! -f "${INSTALL_DIR}/docker-compose.yml" ]] || [[ ! -f "${INSTALL_DIR}/telemt.toml" ]]; then
	err "Не похоже на установку MTProxy (нет docker-compose.yml или telemt.toml): ${INSTALL_DIR}"
fi

if [[ -z "$FORCE" ]] && [[ -t 0 ]]; then
	echo -n "Удалить установку в ${INSTALL_DIR}? [y/N] "
	read -r ans
	[[ "${ans,,}" != "y" && "${ans,,}" != "yes" ]] && exit 0
fi

info "Останавливаю контейнеры..."
(cd "${INSTALL_DIR}" && docker compose down -v 2>/dev/null) || true

info "Удаляю каталог ${INSTALL_DIR}..."
rm -rf "${INSTALL_DIR}"
info "Готово."
