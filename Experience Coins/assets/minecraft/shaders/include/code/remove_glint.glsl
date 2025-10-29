if (all(lessThan(Color.rgb - vec3(0.08, 0.06, 0.07), vec3(0.001)))) {
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, vec4(1.0)) * texelFetch(Sampler2, UV2 / 16, 0);
    gl_Position.z += 0.001;
}