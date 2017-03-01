From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 1 Mar 2017 12:19:23 +0100
Subject: [Intel-wired-lan] Reduce resume times of Ethernet devices
Message-ID: <bc5745a5-b683-259b-b750-8634c12aee06@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


I am analyzing the time spent during resume on a Dell OptiPlex 7010 with 
the script `analyze_suspend.py` [1] in `scripts`.

```
$ more /proc/version
Linux version 4.9.0-2-amd64 (debian-kernel at lists.debian.org) (gcc 
version 6.3.0 20170221 (Debian 6.3.0-8) ) #1 SMP Debian 4.9.13-1 
(2017-02-27)
$ lspci -s 00:19.0 -v
00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network 
Connection (rev 04)
         Subsystem: Dell 82579LM Gigabit Network Connection
         Flags: bus master, fast devsel, latency 0, IRQ 31
         Memory at f7c00000 (32-bit, non-prefetchable) [size=128K]
         Memory at f7c39000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at f080 [size=32]
         Capabilities: <access denied>
         Kernel driver in use: e1000e
         Kernel modules: e1000e
```

The times are quite good already.

> Total Suspend Time: 601 ms	Total Resume Time: 806 ms
> Kernel Suspend: 600.993 ms	Firmware Suspend: 0.000 ms	Firmware Resume: 554.340 ms	Kernel Resume: 251.898 ms

But the resume time is slowed down by the e1000e module, as it takes 
longest, and therefore slowing down the resume.

> e1000e @ 0000:00:19.0 {e1000e} async_device (Total Suspend: 100.518 ms Total Resume: 190.209 ms)

Then I created the callgraph with the command below. (The configs are in 
the upstream suspendresume repository [2].)

```
sudo ./analyze_suspend.py -config config/suspend-callgraph.cfg \
--filter e1000e
```

Please find the HTML file attached.

There it can be seen that most of the time is spent in `e1000e_reset`.

 > e1000e_reset [e1000e] (109.285 ms @ 3485.092445)

Is a reset necessary during resume? Can this be improved, and certain 
things be postponed to later stages?


Kind regards,

Paul


[1] https://01.org/suspendresume/
[2] https://github.com/01org/suspendresume/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: plumpsklo_mem.html.7z
Type: application/x-7z-compressed
Size: 112195 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170301/24392142/attachment-0001.bin>
