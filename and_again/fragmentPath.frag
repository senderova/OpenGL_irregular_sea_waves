#version 330 core
in vec2 TexCoord;

out vec4 color;

void main()
{
    color = vec4(TexCoord, 1.0, 1.0);
}