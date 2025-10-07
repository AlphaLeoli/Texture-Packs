#version 330

vec2 texelSize = 1.0 / OutSize;
vec2 vOffset = vec2(0.0, texelSize.y);
vec2 hOffset = vec2(texelSize.x, 0.0);

float getDepth(vec2 offset) {
    float depth = texture(MainDepthSampler, texCoord + offset).r;
    return (depth * 0.25) + 0.25;
}

vec3 getViewPos(sampler2D depthTex, vec2 uv) {
    float z_ndc = texture(depthTex, uv).r * 2.0 - 1.0;
    vec2 ndc    = uv * 2.0 - 1.0;
    vec4 clip   = vec4(ndc, z_ndc, 1.0);
    vec4 view   = inverse(ProjMat) * clip;
    return view.xyz / view.w;
}

vec3 getNormal(vec2 offset) {
    vec3 p  = getViewPos(MainDepthSampler, texCoord + offset);
    vec3 px = getViewPos(MainDepthSampler, texCoord + offset + hOffset);
    vec3 py = getViewPos(MainDepthSampler, texCoord + offset + vOffset);
    return normalize(cross(px - p, py - p));
}

// Main Code
vec4 getEdgeColor() {
    float centerD = getDepth(vec2(0.0));
    float leftD =   getDepth(-hOffset);
    float rightD =  getDepth(+hOffset);
    float upD =     getDepth(-vOffset);
    float downD =   getDepth(+vOffset);

    float xDiffD =    abs(leftD - rightD);
    float yDiffD =    abs(upD - downD);
    float depthDiff = max(xDiffD, yDiffD);

    float depthEdge = depthDiff; // float(depthDiff > 0.0001 ? 1.0 : 0.0);

    vec3 leftN =   getNormal(-hOffset);
    vec3 rightN =  getNormal(+hOffset);
    vec3 upN =     getNormal(-vOffset);
    vec3 downN =   getNormal(+vOffset);

    float xDiffN = length(leftN - rightN);
    float yDiffN = length(upN - downN);
    float normalDiff = max(xDiffN, yDiffN);

    normalDiff = float(normalDiff > 0.001 ? 1.0 : 0.0);
    float normalEdge = 0.0;
    if (normalDiff > 0.0) {
        normalEdge = normalDiff - centerD;
        //normalEdge = clamp(normalDiff - centerD, 0.0001, 1.0);
        //normalEdge = float(normalEdge > 0.0001 ? 1.0 : 0.0);
    }

    float edge = min(depthEdge, normalEdge);
    edge = float(edge > 0.00002 ? 1.0 : 0.0);

    return vec4(vec3(edge), 1.0);
}