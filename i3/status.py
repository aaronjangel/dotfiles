#!/usr/bin/python3

from i3pystatus import Status


status = Status()
status.register("xkblayout")
status.register("clock", format="%x %X %Z")
#status.register("load", format="L: {avg1} {avg5} {avg15}")
#status.register("temp", format="T: {temp:.0f}°C")
status.register("battery",
    format="B: {status}{percentage:.0f}% {consumption:.2f}W {remaining:%E%h:%M}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    })
status.register("pulseaudio", format="A: {volume}%")
status.register("network", interface="wlp3s0", format_up="{interface}: {essid} {network_graph_recv} {network_graph_sent} {freq:.2f}GHz", freq_divisor=10**9)
status.run()
