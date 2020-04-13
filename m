From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 13 Apr 2020 11:47:21 -0700
Subject: [Intel-wired-lan] BUG: e1000: infinitely loop at
 e1000_set_link_ksettings
In-Reply-To: <20200412191824.GA109724@laptop>
References: <20200412191824.GA109724@laptop>
Message-ID: <CAKgT0Udn3sE4iZci2dRNun6i3DMoG==kuksX_gLXWQORXA1kWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Apr 12, 2020 at 4:12 PM Maxim Zhukov
<mussitantesmortem@gmail.com> wrote:
>
> On Qemu X86 (kernel 5.4.31):
What version of QEMU are you running? That would tell us more about
how the device is being emulated.

> The system-maintenance daemon hangout on D-state at startup on
> ioctl(ETHTOOL_SSET) for setup advertising, duplex, etc...
>
> kgdb stacktrace:
>
> ----
>

I am dropping the first backtrace since it is a symptom of the trace
below. Essentially the issue is all calls to e1000_reinit_locked get
stuck because the __E1000_RESETTING bit is stuck set because this
first thread is stuck waiting on napi_disable to succeed.

> Also stalled workers backtrace:
>
> #3  0xc19e0870 in schedule () at kernel/sched/core.c:4150
> #4  0xc19e2f3e in schedule_timeout (timeout=<optimized out>) at kernel/time/timer.c:1895
> #5  0xc19e3041 in schedule_timeout_uninterruptible (timeout=<optimized out>) at kernel/time/timer.c:1929
> #6  0xc10b3dd1 in msleep (msecs=<optimized out>) at kernel/time/timer.c:2048
> #7  0xc1771fb4 in napi_disable (n=0xdec0b7d8) at net/core/dev.c:6240
> #8  0xc15f0e87 in e1000_down (adapter=0xdec0b540) at drivers/net/ethernet/intel/e1000/e1000_main.c:522
> #9  0xc15f0f35 in e1000_reinit_locked (adapter=0xdec0b540) at drivers/net/ethernet/intel/e1000/e1000_main.c:545
> #10 0xc15f6ecd in e1000_reset_task (work=0xdec0bca0) at drivers/net/ethernet/intel/e1000/e1000_main.c:3506
> #11 0xc106c882 in process_one_work (worker=0xdef4d840, work=0xdec0bca0) at kernel/workqueue.c:2272
> #12 0xc106ccc6 in worker_thread (__worker=0xdef4d840) at kernel/workqueue.c:2418
> #13 0xc1070657 in kthread (_create=0xdf508800) at kernel/kthread.c:255
> #14 0xc19e4078 in ret_from_fork () at arch/x86/entry/entry_32.S:813

So the question I would have is what is causing napi_disable to stall
out? I have looked over the latest QEMU code and the driver code and
both the Tx and Rx paths should have been shut down at the point where
napi_disable is called. I'm assuming there is little to no traffic
present so the NAPI thread shouldn't be stuck in the polling state for
that reason. The only other thing I can think of is that somehow this
is getting scheduled after the interface was already brought down
causing napi_disable to be called a second time for the same NAPI
instance.

A dmesg log for the system at the time of the hang might be useful as
it could include some information on what other configuration options
might have been changed that led to us blocking on the napi_disable
call.

Other than that, how easy is it to trigger this hang. Is this
happening every time you start the guest, or does this just happen
periodically?
