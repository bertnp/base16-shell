#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Paraiso scheme by Jan T. Sott

# This script doesn't support linux console (use 'vconsole' template instead)
if [ "${TERM%%-*}" = 'linux' ]; then
    return 2>/dev/null || exit 0
fi

color00="2f/1e/2e" # Base 00 - Black
color01="ef/61/55" # Base 08 - Red
color02="48/b6/85" # Base 0B - Green
color03="fe/c4/18" # Base 0A - Yellow
color04="06/b6/ef" # Base 0D - Blue
color05="81/5b/a4" # Base 0E - Magenta
color06="5b/c4/bf" # Base 0C - Cyan
color07="a3/9e/9b" # Base 05 - White
color08="77/6e/71" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="e7/e9/db" # Base 07 - Bright White
color16="f9/9b/15" # Base 09
color17="e9/6b/a8" # Base 0F
color18="41/32/3f" # Base 01
color19="4f/42/4c" # Base 02
color20="8d/86/87" # Base 04
color21="b9/b6/b0" # Base 06
color_foreground="a3/9e/9b" # Base 05
color_background="2f/1e/2e" # Base 00
color_background_tmux_format="#2f1e2e"

TMUX_PASSTHRU="$1"
if [ -n "$TMUX_PASSTHRU" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template='\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\'
  printf_template_var='\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\'
  printf_template_custom='\033Ptmux;\033\033]%s%s\033\033\\\033\\'
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template='\033P\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033P\033]%d;rgb:%s\033\\'
  printf_template_custom='\033P\033]%s%s\033\\'
else
  printf_template='\033]4;%d;rgb:%s\033\\'
  printf_template_var='\033]%d;rgb:%s\033\\'
  printf_template_custom='\033]%s%s\033\\'
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# 256 color space
printf $printf_template 16 $color16
printf $printf_template 17 $color17
printf $printf_template 18 $color18
printf $printf_template 19 $color19
printf $printf_template 20 $color20
printf $printf_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  printf $printf_template_custom Pg a39e9b # foreground
  printf $printf_template_custom Ph 2f1e2e # background
  printf $printf_template_custom Pi a39e9b # bold color
  printf $printf_template_custom Pj 4f424c # selection color
  printf $printf_template_custom Pk a39e9b # selected text color
  printf $printf_template_custom Pl a39e9b # cursor
  printf $printf_template_custom Pm 2f1e2e # cursor text
else
  printf $printf_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    printf $printf_template_var 11 $color_background
    if [ -n "$TMUX" ]; then
        tmux selectp -P bg="$color_background_tmux_format"
    fi
    if [ "${TERM%%-*}" = "rxvt" ]; then
      printf $printf_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  printf $printf_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
