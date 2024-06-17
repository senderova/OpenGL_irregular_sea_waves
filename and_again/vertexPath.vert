#version 330 core

#define M_PI 3.1415926535897932384626433832795
#define EXP 2.71828182845904
#define MAX_SIZE 10
#define M_01 0.01
#define W_1 2.63
#define W_m1 2.03

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 texCoord;
layout(location = 2) in float enableYOffset;

out vec2 TexCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;
uniform float lambda[MAX_SIZE];
uniform float k[MAX_SIZE];
uniform float alpha[MAX_SIZE];
uniform float Epsilon[MAX_SIZE * MAX_SIZE];

void main()
{
    float wave = 0;
    float M_02 = 0.13 * M_01;
    float W_m2 = 0.7 * W_m1;
    float W_2 = 0.82 * W_1;
    for (int i = 0 ; i < 10; ++i) {
        for (int j = 0 ; j < 10; ++j) {
            float w = sqrt( k[i] * 9.8 );
            float S_1 = 9.43 * (M_01 / W_1) * pow( (W_m1 / w), 6 ) * pow( EXP, (-1.5 * pow((W_m1 / w), 4 )));
            float S_2 = 17.24 * (M_02 / W_2) * pow( (W_m2 / w), 8 ) * pow(EXP, (-2.0 * pow((W_m2 / w), 2)));
            float S = (2 / M_PI) * (S_1 + S_2) * pow( cos( alpha[j] ), 2 ); // 0.00157
            float apmlity = sqrt( (2 / M_PI) * S );
            wave += apmlity * cos( w * 0.5 * time - k[i] * ( position.x * cos(lambda[j]) + position.z * cos(lambda[j]) ) + Epsilon[j * 10 + i]);
        }
    }
    gl_Position = projection * view * model * vec4(position.x, position.y + wave, position.z, 1.0f);
    TexCoord = vec2(texCoord.x / 2, texCoord.y / 2);
}