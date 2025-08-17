#version 150

vec2 texelSize = 1.0 / OutSize;
vec2 vOffset = vec2(0.0, texelSize.y);
vec2 hOffset = vec2(texelSize.x, 0.0);

const float near = 0.1; 
const float far  = 1.0; 

float linearizeDepth(float depth) {
    float z = depth * 2.0 - 1.0;
    return (2.0 * near * far) / (far + near - z * (far - near));    
}

float getDepth(vec2 offset) {
    float depth = texture(MainDepthSampler, texCoord + offset).r;
    return linearizeDepth(depth);//(depth * 0.25) + 0.25;
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
    vec3 px = getViewPos(MainDepthSampler, texCoord + offset + vec2(texelSize.x, 0.0));
    vec3 py = getViewPos(MainDepthSampler, texCoord + offset + vec2(0.0, texelSize.y));
    return normalize(cross(px - p, py - p));
}

vec4 getEdgeColor() {
    // Find the differences between neighboring depths
    float leftDepth =  getDepth(-hOffset);
    float rightDepth = getDepth(+hOffset);
    float upDepth =    getDepth(-vOffset);
    float downDepth =  getDepth(+vOffset);
    float DepthDiffX = abs(leftDepth - rightDepth);
    float DepthDiffY = abs(upDepth - downDepth);

    // The biggest difference is the edge
    float depthDiff = max(DepthDiffX, DepthDiffY);
    float depthEdge = float(depthDiff > 0.0001 ? 1.0 : 0.0);

    // Find the differences between neighboring normals
    vec3 leftNormal =   getNormal(-hOffset);
    vec3 rightNormal =  getNormal(+hOffset);
    vec3 upNormal =     getNormal(-vOffset);
    vec3 downNormal =   getNormal(+vOffset);
    float NormalDiffX = length(leftNormal - rightNormal);
    float NormalDiffY = length(upNormal - downNormal);

    // The biggest difference is the edge
    float normalDiff = max(NormalDiffX, NormalDiffY);
    float normalEdge = float(normalDiff > 0.001 ? 1.0 : 0.0);

    // We want the edge to be the depth edge, since it loses detail from further away.
    float edge = depthEdge;
    // Since the normal edge contains every possible depth edge pixel (that we want),
    // multiplying it gets rid of the artifacts that appear up close.
    edge *= normalEdge;

    return vec4(vec3(edge), 1.0);
}