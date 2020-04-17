From: Maxim Zhukov <mussitantesmortem@gmail.com>
Date: Fri, 17 Apr 2020 13:45:29 +0300
Subject: [Intel-wired-lan] [RFC PATCH] e1000: Do not perform reset in
 reset_task if we are already down
In-Reply-To: <20200416203151.10210.78244.stgit@localhost.localdomain>
References: <20200414184547.ue7mvj6olmr76m2i@laptop>
 <20200416203151.10210.78244.stgit@localhost.localdomain>
Message-ID: <20200417104529.GA462877@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Tests with this patch passed. the qemu has been rebooted 652 times.

In one of reboots there was the kernel panic but that was for another
reason (not related to this patch)

[    0.270350 ] APIC: Switch to symmetric I/O mode setup
[    0.275011 ] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.277987 ] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.294652 ] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.296219 ] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.297794 ] ..... (found apic 0 pin 2) ...
[    0.311109 ] ....... failed.
[    0.311951 ] ...trying to set up timer as Virtual Wire IRQ...
[    0.326077 ] ..... failed.
[    0.326712 ] ...trying to set up timer as ExtINT IRQ...
[    0.556375 ] ..... failed :(.
[    0.557337 ] Kernel panic - not syncing: IO-APIC + timer doesn't
work!  Boot with apic=debug and send a report.  Then try booting with
the 'noapic' option.
[    0.564541 ] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.32+ #4
[    0.566470 ] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20191223_100556-anatol 04/01/2014
[    0.575980 ] Call Trace:
[    0.577065 ]  dump_stack+0x4f/0x66
[    0.578109 ]  panic+0xa3/0x256
[    0.578937 ]  setup_IO_APIC+0x714/0x764
[    0.579958 ]  ? clear_IO_APIC+0x3c/0x60
[    0.581086 ]  apic_intr_mode_init+0x108/0x10f
[    0.582382 ]  x86_late_time_init+0x1d/0x24
[    0.583593 ]  start_kernel+0x378/0x426
[    0.585657 ]  i386_start_kernel+0x48/0x4a
[    0.586955 ]  startup_32_smp+0x164/0x168
[    0.588293 ] ---[ end Kernel panic - not syncing: IO-APIC + timer
doesn't work!  Boot with apic=debug and send a report.  Then try booting
with the 'noapic' option. ]---
)

Tested-by: Maxim Zhukov <mussitantesmortem@gmail.com>

On Thu, Apr 16, 2020 at 01:34:19PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> We are seeing a deadlock in e1000 down when NAPI is being disabled. Looking
> over the kernel function trace of the system it appears that the interface
> is being closed and then a reset is hitting which deadlocks the interface
> as the NAPI interface is already disabled.
> 
> To prevent this from happening I am disabling the reset task when
> __E1000_DOWN is already set. In addition code has been added so that we set
> the __E1000_DOWN while holding the __E1000_RESET flag in e1000_close in
> order to guarantee that the reset task will not run after we have started
> the close call.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> 
> Maxim,
> 
> If possible I would appreciate it if you could try this patch and see if
> it addresses the issues you were seeing. From what I can tell this issue
> is due to the interface being closed around the same time a reset is
> scheduled so the two are racing and resulting in down being called after
> a down was already completed. Adding this test for the down flag should
> correct that.
> 
> If it does I will resubmit this patch as a non-RFC.
> 
> Thanks.
> 
> Alex
> 
>  drivers/net/ethernet/intel/e1000/e1000_main.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index f7103356ef56..566bbcb74056 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -542,8 +542,13 @@ void e1000_reinit_locked(struct e1000_adapter *adapter)
>  	WARN_ON(in_interrupt());
>  	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags))
>  		msleep(1);
> -	e1000_down(adapter);
> -	e1000_up(adapter);
> +
> +	/* only run the task if not already down */
> +	if (!test_bit(__E1000_DOWN, &adapter->flags)) {
> +		e1000_down(adapter);
> +		e1000_up(adapter);
> +	}
> +
>  	clear_bit(__E1000_RESETTING, &adapter->flags);
>  }
>  
> @@ -1433,10 +1438,15 @@ int e1000_close(struct net_device *netdev)
>  	struct e1000_hw *hw = &adapter->hw;
>  	int count = E1000_CHECK_RESET_COUNT;
>  
> -	while (test_bit(__E1000_RESETTING, &adapter->flags) && count--)
> +	while (test_and_set_bit(__E1000_RESETTING, &adapter->flags) && count--)
>  		usleep_range(10000, 20000);
>  
> -	WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
> +	WARN_ON(count < 0);
> +
> +	/* signal that we're down so that the reset task will no longer run */
> +	set_bit(__E1000_DOWN, &adapter->flags);
> +	clear_bit(__E1000_RESETTING, &adapter->flags);
> +
>  	e1000_down(adapter);
>  	e1000_power_down_phy(adapter);
>  	e1000_free_irq(adapter);
> 
