shader_type canvas_item;

uniform float beat_speed : hint_range(0.1, 5.0) = 2.0;
uniform float beat_intensity : hint_range(0.0, 0.5) = 0.1;

void vertex() {
    float zoom_factor = 1.0 + sin(TIME * beat_speed) * beat_intensity;
    VERTEX *= zoom_factor;
}