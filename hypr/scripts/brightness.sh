#!/bin/bash

SHADER_FILE="$HOME/.config/hypr/shaders/brightness.glsl"
STATE_FILE="/tmp/brightness_value"

if [ ! -f "$STATE_FILE" ]; then
    echo "0.60" > "$STATE_FILE"
fi

CURRENT=$(cat "$STATE_FILE")

case "$1" in
    up)
        NEW=$(echo "scale=2; $CURRENT + 0.10" | bc)
        if (( $(echo "$NEW > 1.00" | bc -l) )); then NEW="1.00"; fi
        ;;
    down)
        NEW=$(echo "scale=2; $CURRENT - 0.10" | bc)
        if (( $(echo "$NEW < 0.10" | bc -l) )); then NEW="0.10"; fi
        ;;
    *)
        exit 1
        ;;
esac

echo "$NEW" > "$STATE_FILE"

cat > "$SHADER_FILE" << GLSL
#version 300 es
precision mediump float;
in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    vec4 color = texture(tex, v_texcoord);
    fragColor = vec4(color.rgb * ${NEW}, color.a);
}
GLSL

hyprctl keyword decoration:screen_shader "$SHADER_FILE"
