================================================================================
性能测试摘要
================================================================================

名称                   实际时间            用户时间            系统时间            相对速度      
--------------------------------------------------------------------------------
edge-tts             1.314s ±0.304   0.768s          0.092s          1.00x     
neutts-onnx-gguf     312.928s ±5.533 327.890s        5.724s          238.15x   
neutts-onnx          314.416s ±7.989 327.152s        6.308s          239.28x   
neutts-gguf          355.894s ±12.938 354.432s        7.822s          270.85x   
neutts               559.490s ±32.808 504.828s        16.092s         425.79x   

详细统计:

[edge-tts]
  命令: /usr/local/envs/neutts-air/bin/edge-tts --text "So we found being competitive and collaborative was a huge way of staying motivated towards our goals, so one person to call when you fall off, one person who gets you back on then one person to actually do the activity with." --write-media ./outputs/dave-edge-tts.wav
  平均实际时间: 1.314s (最小: 0.930s, 最大: 1.690s)
  平均用户时间: 0.768s
  平均系统时间: 0.092s
  平均CPU时间:  0.860s
  标准差: 0.304s
  🏆 最快!

[neutts-onnx-gguf]
  命令: /usr/local/envs/neutts-air/bin/python -m examples.onnx_example --input_text "So we found being competitive and collaborative was a huge way of staying motivated towards our goals, so one person to call when you fall off, one person who gets you back on then one person to actually do the activity with." --ref_text ./samples/dave.txt --ref_codes samples/dave.pt --backbone neuphonic/neutts-air-q4-gguf
  平均实际时间: 312.928s (最小: 306.160s, 最大: 318.650s)
  平均用户时间: 327.890s
  平均系统时间: 5.724s
  平均CPU时间:  333.614s
  标准差: 5.533s
  比最快慢 23714.9% (238.15x)

[neutts-onnx]
  命令: /usr/local/envs/neutts-air/bin/python -m examples.onnx_example --input_text "So we found being competitive and collaborative was a huge way of staying motivated towards our goals, so one person to call when you fall off, one person who gets you back on then one person to actually do the activity with." --ref_text ./samples/dave.txt --ref_codes samples/dave.pt --backbone neuphonic/neutts-air-q4-gguf
  平均实际时间: 314.416s (最小: 307.410s, 最大: 328.150s)
  平均用户时间: 327.152s
  平均系统时间: 6.308s
  平均CPU时间:  333.460s
  标准差: 7.989s
  比最快慢 23828.2% (239.28x)

[neutts-gguf]
  命令: /usr/local/envs/neutts-air/bin/python -m examples.basic_example --input_text "So we found being competitive and collaborative was a huge way of staying motivated towards our goals, so one person to call when you fall off, one person who gets you back on then one person to actually do the activity with." --ref_audio ./samples/dave.wav --ref_text ./samples/dave.txt --backbone neuphonic/neutts-air-q4-gguf
  平均实际时间: 355.894s (最小: 336.950s, 最大: 368.430s)
  平均用户时间: 354.432s
  平均系统时间: 7.822s
  平均CPU时间:  362.254s
  标准差: 12.938s
  比最快慢 26984.8% (270.85x)

[neutts]
  命令: /usr/local/envs/neutts-air/bin/python -m examples.basic_example --input_text "So we found being competitive and collaborative was a huge way of staying motivated towards our goals, so one person to call when you fall off, one person who gets you back on then one person to actually do the activity with." --ref_audio ./samples/dave.wav --ref_text ./samples/dave.txt
  平均实际时间: 559.490s (最小: 510.540s, 最大: 600.270s)
  平均用户时间: 504.828s
  平均系统时间: 16.092s
  平均CPU时间:  520.920s
  标准差: 32.808s
  比最快慢 42479.1% (425.79x)

失败的测试:
  ✗ [chattts]: 命令执行失败
  ✗ [chattts-refine]: 命令执行失败

结果已保存到: performance.json