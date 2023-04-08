void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    float jacked_time = 5.5*iTime;
    const vec2 scale = vec2(.5);
   	
    uv += 0.01*sin(scale*jacked_time + length( uv )*10.0);
    fragColor = texture(iChannel0, uv).rgba;
}