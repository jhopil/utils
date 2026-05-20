# tmux

터미널에서 여러 세션·창·패널을 한 화면에서 관리하는 멀티플렉서입니다. SSH 연결이 끊겨도 백그라운드 세션이 유지됩니다.

## 설치

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install tmux
```

### Fedora / RHEL

```bash
sudo dnf install tmux
```

### Arch Linux

```bash
sudo pacman -S tmux
```

### macOS (Homebrew)

```bash
brew install tmux
```

설치 확인:

```bash
tmux -V
```

## 기본 개념

| 용어 | 설명 |
|------|------|
| **session** | 독립된 tmux 환경 (예: `esba`) |
| **window** | 세션 안의 탭 |
| **pane** | 창을 나눈 분할 영역 |

기본 prefix 키: **`Ctrl+b`** (다음 단축키는 prefix 이후에 누름)

## 세션

```bash
tmux new -s esba          # 이름이 esba인 새 세션
tmux attach -t esba       # esba 세션에 붙기
tmux ls                   # 세션 목록
tmux kill-session -t esba # 세션 종료
```

| 동작 | 단축키 |
|------|--------|
| 세션에서 빠져나오기 (detach, 세션은 유지) | `Ctrl+b` `d` |
| 세션 이름 바꾸기 | `Ctrl+b` `$` |

이 저장소의 `tmux.sh`는 `esba` 세션에 attach 하는 래퍼입니다.

```bash
./tmux.sh
```

## 패널 (pane)

| 동작 | 단축키 |
|------|--------|
| 세로 분할 | `Ctrl+b` `%` |
| 가로 분할 | `Ctrl+b` `"` |
| 패널 번호 표시 | `Ctrl+b` `q` |
| 현재 패널만 남기기 | `Ctrl+b` `!` |
| 패널 닫기 | `Ctrl+b` `x` |
| 셸 종료 (패널 닫힘) | `Ctrl+d` |
| 패널로 이동 | `Ctrl+b` `o` 또는 방향키 |
| 패널 인덱스로 이동 | `Ctrl+b` `'` 후 번호 |
| 패널 크기 조절 | `Ctrl+b` `Ctrl+방향키` |
| 패널과 명령 프롬프트 | `Ctrl+b` `:` |

## 창 (window)

| 동작 | 단축키 |
|------|--------|
| 새 창 | `Ctrl+b` `c` |
| 다음 / 이전 창 | `Ctrl+b` `n` / `p` |
| 번호로 이동 | `Ctrl+b` `0`–`9` |
| 창 닫기 | `Ctrl+b` `&` |
| 창 이름 변경 | `Ctrl+b` `,` |

## 스크롤·복사 (copy mode)

| 동작 | 단축키 |
|------|--------|
| 스크롤 / 복사 모드 진입 | `Ctrl+b` `[` |
| 복사 모드 종료 | `q` 또는 `Esc` |
| 위/아래 스크롤 | `PgUp` / `PgDn` 또는 `Ctrl+u` / `Ctrl+d` |
| 선택 후 복사 (기본) | 스페이스로 시작, Enter로 복사 |
| 붙여넣기 | `Ctrl+b` `]` |

## 기타 유용한 기능

| 동작 | 단축키 / 명령 |
|------|----------------|
| 도움말 (모든 바인딩) | `Ctrl+b` `?` |
| 명령 모드 | `Ctrl+b` `:` |
| 동기화 입력 (모든 패널에 같은 키) | `Ctrl+b` `:` → `setw synchronize-panes` |
| 레이아웃 순환 | `Ctrl+b` `Space` |
| 마지막 패널 토글 | `Ctrl+b` `;` |
| 현재 경로를 새 패널/창에서 열기 | `Ctrl+b` `:` → `split-window -c "#{pane_current_path}"` |

## 설정 (~/.tmux.conf) 예시

```bash
# prefix를 Ctrl+a로 변경 (선택)
# set -g prefix C-a
# unbind C-b
# bind C-a send-prefix

# 마우스로 패널 선택·크기 조절
set -g mouse on

# 창/패널 인덱스를 1부터
set -g base-index 1
setw -g pane-base-index 1

# 히스토리 줄 수
set -g history-limit 50000

# 새 세션/창의 기본 셸
# set -g default-shell /usr/bin/zsh
```

적용:

```bash
tmux source-file ~/.tmux.conf
```

또는 tmux를 한 번 종료한 뒤 다시 시작합니다.

## 자주 쓰는 워크플로

1. **원격 서버**: `tmux new -s work` → 작업 후 `Ctrl+b` `d` → SSH 끊김 → 다시 접속 후 `tmux attach -t work`
2. **로컬 개발**: 세션 하나에 창 여러 개 (에디터, 서버, 로그) 또는 한 창에 패널 분할
3. **팀과 같은 세션 공유**: `tmux new -s pair` 후 다른 사용자가 `tmux attach -t pair` (같은 Unix 사용자/권한 필요)

## 참고

- [tmux 공식 위키](https://github.com/tmux/tmux/wiki)
- 프로젝트 스크립트: [`tmux.sh`](./tmux.sh)
