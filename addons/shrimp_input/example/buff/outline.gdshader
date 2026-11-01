shader_type canvas_item;

// ================ 可调整的 uniform 参数 ================
// 描边纯色，您可以在材质属性面板中调整
uniform vec4 line_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // 默认为黑色
// 描边线条宽度（范围：0.5到5像素）
uniform float line_width : hint_range(0.5, 50) = 1.5;

void fragment() {
    // 获取纹理的像素大小（1/宽度，1/高度）
    vec2 texel_size = 1.0 / vec2(textureSize(TEXTURE, 0));
    
    // 定义采样偏移量，基于线条宽度动态调整
    // 这里使用4个基本方向（上、下、左、右）进行边缘检测
    vec2 offsets[4] = vec2[](
        vec2(0.0, -1.0),  // 上
        vec2(0.0,  1.0),  // 下
        vec2(-1.0, 0.0),  // 左
        vec2( 1.0, 0.0)   // 右
    );
    
    // 采样当前像素的透明度
    float current_alpha = texture(TEXTURE, UV).a;
    
    // 计算采样步长，确保覆盖线条宽度
    float step_size = line_width * texel_size.x;
    
    // 边缘检测：检查周围像素是否透明
    bool is_edge = false;
    for (int i = 0; i < 4; i++) {
        vec2 sample_uv = UV + offsets[i] * step_size;
        // 确保采样UV在纹理范围内
        sample_uv = clamp(sample_uv, vec2(0.0), vec2(1.0));
        float sample_alpha = texture(TEXTURE, sample_uv).a;
        // 如果当前像素不透明，但周围有透明像素，则认为当前像素是边缘
        if (current_alpha > 0.0 && sample_alpha < 0.1) {
            is_edge = true;
            break;
        }
    }
    
    // 根据是否是边缘，决定最终颜色
    if (is_edge) {
        // 是边缘，使用描边纯色
        COLOR = line_color;
    } else {
        // 不是边缘，使用原始纹理颜色
        COLOR = texture(TEXTURE, UV);
    }
}
