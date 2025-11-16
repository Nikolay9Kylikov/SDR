# gen_rom.py
import numpy as np # create sin/cos values

N = 4096      # table length (ADDR_W=12)
A = 2**15-1   # signed 16-bit peak (Q1.15 if you want 15 fractional bits)

with open("sin_rom.hex","w") as fs, open("cos_rom.hex","w") as fc:
    for i in range(N):
        angle = 2.0*np.pi * i / N
        s = int(np.round(A * np.sin(angle))) & 0xFFFF
        c = int(np.round(A * np.cos(angle))) & 0xFFFF
        fs.write("{:04x}\n".format(s))
        fc.write("{:04x}\n".format(c))
