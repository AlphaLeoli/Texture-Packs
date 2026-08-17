vec4 getLegoColor() {
	// Create Tiling
	vec2 scale = OutSize / (15.0 * LEGO_SIZE);
	vec2 uv = texCoord * scale;
	vec3 color = texture(InSampler, round(uv) * (1.0 / scale)).rgb;

	// Quantize Color
	// color = texture(LutSampler, (vec2(color.r + color.g * 32.0, color.b) + 0.5) / vec2(1024.0, 32.0)).rgb;
	#if USE_LEGO_COLORS
	vec2 halfPixelSize = 0.5 / vec2(1024.0, 32.0);
	color = texture(LutSampler, clamp(vec2(color.b / 32.0 + floor(color.g * 32.0) / 32.0, 1.0 - color.r) - halfPixelSize, vec2(0.0), vec2(1.0) - halfPixelSize)).rgb;
	#endif

	// Apply Overlay
	uv = vec2(uv.x, 1.0 - uv.y);
	uv += 0.5;
	vec4 highlight = texture(HighlightSampler, uv);
	vec3 lego = texture(LegoSampler, uv).rgb;
    return vec4(color * lego + highlight.a, 1.0);
}