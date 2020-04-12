From: Maxim Zhukov <mussitantesmortem@gmail.com>
Date: Sun, 12 Apr 2020 22:18:24 +0300
Subject: [Intel-wired-lan] BUG: e1000: infinitely loop at
 e1000_set_link_ksettings
Message-ID: <20200412191824.GA109724@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Qemu X86 (kernel 5.4.31):
The system-maintenance daemon hangout on D-state at startup on
ioctl(ETHTOOL_SSET) for setup advertising, duplex, etc...

kgdb stacktrace:

----

#0  0x00000000 in ?? ()
#1  0x00000046 in ?? ()
#2  0xdf59b780 in ?? ()
#3  0xc19e0870 in schedule () at kernel/sched/core.c:4150
#4  0xc19e2f3e in schedule_timeout (timeout=<optimized out>) at kernel/time/timer.c:1895
#5  0xc19e3041 in schedule_timeout_uninterruptible (timeout=<optimized out>) at kernel/time/timer.c:1929
#6  0xc10b3dd1 in msleep (msecs=<optimized out>) at kernel/time/timer.c:2048
#7  0xc160345d in e1000_set_link_ksettings (netdev=0xdec0b000, cmd=0xde47fe00) at drivers/net/ethernet/intel/e1000/e1000_ethtool.c:190
#8  0xc177b377 in ethtool_set_settings (dev=0xdec0b000, useraddr=0xbfc33620) at net/core/ethtool.c:757
#9  0xc177fb1a in dev_ethtool (net=0xc1e84480 <init_net>, ifr=<optimized out>) at net/core/ethtool.c:2637
#10 0xc179e313 in dev_ioctl (net=0xc1e84480 <init_net>, cmd=<optimized out>, ifr=0xde47feb4, need_copyout=0xde47feac) at net/core/dev_ioctl.c:424
#11 0xc1755861 in sock_do_ioctl (net=0xc1e84480 <init_net>, sock=<optimized out>, cmd=35142, arg=3217241600) at net/socket.c:1061
#12 0xc1755b61 in sock_ioctl (file=<optimized out>, cmd=35142, arg=<optimized out>) at net/socket.c:1189
#13 0xc11986fe in vfs_ioctl (filp=<optimized out>, cmd=<optimized out>, arg=<optimized out>) at fs/ioctl.c:47
#14 0xc11994da in do_vfs_ioctl (filp=<optimized out>, fd=24, cmd=<optimized out>, arg=3217241600) at fs/ioctl.c:699
#15 0xc119955e in ksys_ioctl (fd=<optimized out>, cmd=<optimized out>, arg=<optimized out>) at fs/ioctl.c:714
#16 0xc1199586 in __do_sys_ioctl (arg=<optimized out>, cmd=<optimized out>, fd=<optimized out>) at fs/ioctl.c:721
#17 __se_sys_ioctl (fd=24, cmd=35142, arg=-1077725696) at fs/ioctl.c:719
#18 0xc10020d6 in do_syscall_32_irqs_on (regs=<optimized out>) at arch/x86/entry/common.c:341
#19 do_fast_syscall_32 (regs=0xde47ffb4) at arch/x86/entry/common.c:404


frame 7:

189		while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
190			msleep(1);
191


Also stalled workers backtrace:

#3  0xc19e0870 in schedule () at kernel/sched/core.c:4150
#4  0xc19e2f3e in schedule_timeout (timeout=<optimized out>) at kernel/time/timer.c:1895
#5  0xc19e3041 in schedule_timeout_uninterruptible (timeout=<optimized out>) at kernel/time/timer.c:1929
#6  0xc10b3dd1 in msleep (msecs=<optimized out>) at kernel/time/timer.c:2048
#7  0xc1771fb4 in napi_disable (n=0xdec0b7d8) at net/core/dev.c:6240
#8  0xc15f0e87 in e1000_down (adapter=0xdec0b540) at drivers/net/ethernet/intel/e1000/e1000_main.c:522
#9  0xc15f0f35 in e1000_reinit_locked (adapter=0xdec0b540) at drivers/net/ethernet/intel/e1000/e1000_main.c:545
#10 0xc15f6ecd in e1000_reset_task (work=0xdec0bca0) at drivers/net/ethernet/intel/e1000/e1000_main.c:3506
#11 0xc106c882 in process_one_work (worker=0xdef4d840, work=0xdec0bca0) at kernel/workqueue.c:2272
#12 0xc106ccc6 in worker_thread (__worker=0xdef4d840) at kernel/workqueue.c:2418
#13 0xc1070657 in kthread (_create=0xdf508800) at kernel/kthread.c:255
#14 0xc19e4078 in ret_from_fork () at arch/x86/entry/entry_32.S:813


-----

If you need any additional information, I am entirely at your disposal.
Thanks!
