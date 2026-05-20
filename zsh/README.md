# zsh

Bash와 호환되면서 강한 자동완성·글로빙·플러그인을 제공하는 셸입니다. 대화형 터미널 작업에 많이 쓰입니다.

## 설치

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install zsh
```

### Fedora / RHEL

```bash
sudo dnf install zsh
```

### Arch Linux

```bash
sudo pacman -S zsh
```

### macOS

macOS Catalina(10.15) 이후 기본 로그인 셸이 zsh입니다. Homebrew로 최신 버전 설치:

```bash
brew install zsh
```

설치 확인:

```bash
zsh --version
which zsh
```

## 기본 셸로 설정

```bash
# zsh 경로 확인 (보통 /usr/bin/zsh 또는 /bin/zsh)
which zsh

# 로그인 셸 변경 (비밀번호 입력)
chsh -s "$(which zsh)"

# 현재 세션만 zsh 실행
zsh
```

`/etc/shells`에 zsh가 없으면 관리자가 해당 경로를 추가해야 `chsh`가 동작합니다.

## 설정 파일

| 파일 | 용도 |
|------|------|
| `~/.zshrc` | 대화형 셸마다 로드 (alias, prompt, plugin) |
| `~/.zshenv` | 모든 zsh 인스턴스 (환경 변수) |
| `~/.zprofile` | 로그인 셸 |
| `~/.zlogin` | 로그인 후 |
| `~/.zlogout` | 로그아웃 시 |

설정 반영:

```bash
source ~/.zshrc
```

## Oh My Zsh (선택)

테마·플러그인·alias를 묶어 쓰기 쉽게 해 주는 프레임워크입니다.

```bash
# 설치 (공식 설치 스크립트)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 테마: ~/.zshrc 의 ZSH_THEME
# 플러그인: plugins=(git z kubectl ...)
```

대안: [Prezto](https://github.com/sorin-ionescu/prezto), [zinit](https://github.com/zdharma-continuum/zinit), [antidote](https://github.com/mattmc3/antidote) 등.

## 유용한 내장 기능

### 히스토리

```bash
history          # 이전 명령 목록
!!               # 직전 명령 다시 실행
!n               # history 번호 n 실행
!string          # string으로 시작하는 가장 최근 명령
^old^new         # 직전 명령에서 old → new 치환 후 실행
```

`~/.zshrc` 예시:

```bash
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY      # 세션 간 히스토리 공유
setopt HIST_IGNORE_DUPS   # 연속 동일 명령은 한 번만
setopt HIST_VERIFY        # ! 치환 후 실행 전 확인
```

### 디렉터리 이동

```bash
cd -             # 이전 디렉터리
dirs -v          # 디렉터리 스택
pushd /path      # 스택에 넣고 이동
popd             # 스택에서 꺼내 이동
```

`setopt AUTO_CD` — 경로만 입력해도 `cd` (예: `~/project`).

`setopt AUTO_PUSHD` / `setopt PUSHD_IGNORE_DUPS` — `cd` 시 스택 자동 관리.

### 글로빙 (패턴)

```bash
ls *.txt         # 확장
ls **/*.go       # ** 재귀 (setopt GLOBSTAR)
ls file(N)       # 숫자 정렬
ls *(m-7)        # 7일 이내 수정
```

`setopt EXTENDED_GLOB` — `~(pattern)`, `^pattern` 등 고급 패턴.

### 자동완성

`Tab` — 메뉴·순환 완성 (설정에 따라 다름).

```bash
# ~/.zshrc
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # 대소문자 무시
```

### 명령 수정·추천

```bash
# ~/.zshrc
setopt CORRECT          # 오타 시 수정 제안
setopt CORRECT_ALL
```

`command not found` 시 [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) 플러그인을 많이 씁니다.

## 자주 쓰는 단축키 (emacs 모드, 기본)

| 단축키 | 동작 |
|--------|------|
| `Ctrl+a` | 줄 맨 앞 |
| `Ctrl+e` | 줄 맨 뒤 |
| `Ctrl+u` | 커서 앞까지 삭제 |
| `Ctrl+k` | 커서 뒤까지 삭제 |
| `Ctrl+w` | 단어 단위 삭제 |
| `Ctrl+r` | 역방향 히스토리 검색 |
| `Ctrl+l` | 화면 지우기 |
| `Ctrl+z` | 프로세스 일시 정지 (`fg`로 복귀) |
| `Alt+.` | 직전 명령의 마지막 인자 |

vi 모드: `bindkey -v` 후 `Esc`로 normal 모드.

## alias·함수 예시

```bash
# ~/.zshrc
alias ll='ls -lah'
alias gs='git status'
alias gc='git commit'

# 디렉터리 생성 후 이동
mkcd() { mkdir -p "$1" && cd "$1"; }
```

## 환경·경로

```bash
export EDITOR=vim
export PATH="$HOME/bin:$PATH"

# 여러 줄
path=(
  $HOME/.local/bin
  /usr/local/go/bin
  $path
)
export PATH
```

## Bash와 차이 (요약)

| 항목 | Bash | zsh |
|------|------|-----|
| 설정 | `~/.bashrc` | `~/.zshrc` |
| 배열 인덱스 | 0부터 | 1부터 (기본) |
| 글로빙 | 단순 | 확장·한정자 풍부 |
| 플러그인 | 제한적 | Oh My Zsh 등 생태계 큼 |
| 스크립트 | `/bin/bash` | 호환 많지만 스크립트는 `#!/bin/bash` 유지하는 경우 많음 |

대화형 셸은 zsh, 배포·CI 스크립트는 bash를 쓰는 조합이 흔합니다.

## 최소 ~/.zshrc 예시

```bash
# 히스토리
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS

# 옵션
setopt AUTO_CD EXTENDED_GLOB GLOBSTAR
setopt CORRECT

# 완성
autoload -Uz compinit && compinit

# prompt (간단)
PROMPT='%F{green}%n@%m%f %~ %# '

# alias
alias ll='ls -lah'
```

## 자주 쓰는 워크플로

1. **새 머신**: `zsh` 설치 → `chsh` → `~/.zshrc` 작성 또는 Oh My Zsh 설치
2. **Git 작업**: `git` 플러그인 + alias (`gco`, `gst` 등)
3. **원격 SSH**: 서버에도 zsh·동일 `~/.zshrc` 동기화 (dotfiles, chezmoi 등)
4. **tmux와 함께**: tmux 기본 셸을 zsh로 (`set -g default-shell /usr/bin/zsh`)

## 참고

- [Zsh 공식 문서](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh](https://ohmyzsh.sh/)
- 관련: [`../tmux/README.md`](../tmux/README.md) — tmux에서 zsh를 기본 셸로 쓰는 설정
