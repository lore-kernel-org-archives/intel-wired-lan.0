From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 26 Jul 2018 07:32:18 -0700
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <931347915.758706.1532606173777@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
Message-ID: <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 26, 2018 at 4:56 AM, Marco Berizzi <pupilla@libero.it> wrote:
>> Il 5 luglio 2018 alle 15.22 Marco Berizzi <pupilla@libero.it> ha scritto:
>>
>> > Il 5 giugno 2018 alle 10.12 Marco Berizzi <pupilla@libero.it> ha scritto:
>> >
>> > Hi Folks,
>> >
>> > after upgrading from 4.16.13 to 4.17 I got this error message.
>> >
>> > Any feedback are welcome.
>> >
>> > Marco Berizzi
>> >
>> > PS: this system is running oracle virtualbox 5.2.12
>>
>> Hi Folks,
>>
>> I'm getting the same error also with 4.17.3:
>
> Hi Folks,
>
> I'm getting the same error also with 4.18-r6 (this system is
> running oracle virtualbox 5.2.16):

Could you include an lspci -vvv for the igb functions. Also I assume
this is a direct assigned port?

From what I can get based on the log below somehow the driver and the
device are falling out of sync. It looks like either we missed a tail
update at some point after we stopped the queue.

It looks like the error took 2 to 3 days to show up. Do you know if
there are any reproduction steps that might let us start bisecting
this, or that would at least allow us to reproduce the issue more
quickly? Also, what sort of traffic are you sending over the port?

> [226277.797573] igb 0000:08:00.0: Detected Tx Unit Hang
>                   Tx Queue             <2>
>                   TDH                  <de>
>                   TDT                  <de>
>                   next_to_use          <e0>
>                   next_to_clean        <de>
>                 buffer_info[next_to_clean]
>                   time_stamp           <10d782971>
>                   next_to_watch        <0000000095a05ad2>
>                   jiffies              <10d783141>
>                   desc.status          <238220>
> [226279.780541] igb 0000:08:00.0: Detected Tx Unit Hang
>                   Tx Queue             <2>
>                   TDH                  <de>
>                   TDT                  <de>
>                   next_to_use          <e0>
>                   next_to_clean        <de>
>                 buffer_info[next_to_clean]
>                   time_stamp           <10d782971>
>                   next_to_watch        <0000000095a05ad2>
>                   jiffies              <10d783900>
>                   desc.status          <238220>
> [226281.764513] igb 0000:08:00.0: Detected Tx Unit Hang
>                   Tx Queue             <2>
>                   TDH                  <de>
>                   TDT                  <de>
>                   next_to_use          <e0>
>                   next_to_clean        <de>
>                 buffer_info[next_to_clean]
>                   time_stamp           <10d782971>
>                   next_to_watch        <0000000095a05ad2>
>                   jiffies              <10d7840c0>
>                   desc.status          <238220>
> [226283.749485] igb 0000:08:00.0: Detected Tx Unit Hang
>                   Tx Queue             <2>
>                   TDH                  <de>
>                   TDT                  <de>
>                   next_to_use          <e0>
>                   next_to_clean        <de>
>                 buffer_info[next_to_clean]
>                   time_stamp           <10d782971>
>                   next_to_watch        <0000000095a05ad2>
>                   jiffies              <10d784881>
>                   desc.status          <238220>
> [226285.156354] ------------[ cut here ]------------
> [226285.156359] NETDEV WATCHDOG: eth0 (igb): transmit queue 2 timed out
> [226285.156381] WARNING: CPU: 10 PID: 0 at net/sched/sch_generic.c:461 dev_watchdog+0x1d9/0x1e0
> [226285.156382] Modules linked in: vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) uhci_hcd igb ehci_pci ptp ehci_hcd 8250 evdev pps_core button 8250_base usbcore i2c_i801 i2c_algo_bit serial_core usb_common i2c_core loop
> [226285.156399] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G          IO      4.18.0-rc6 #1
> [226285.156400] Hardware name: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
> [226285.156403] RIP: 0010:dev_watchdog+0x1d9/0x1e0
> [226285.156404] Code: 00 48 63 4d f0 eb 97 4c 89 e7 c6 05 ca e3 83 00 01 e8 ab eb fd ff 89 d9 4c 89 e6 48 c7 c7 c0 48 b3 81 48 89 c2 e8 97 22 c3 ff <0f> 0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00
> [226285.156437] RSP: 0018:ffff880fff283ec8 EFLAGS: 00010286
> [226285.156439] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000006
> [226285.156440] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff880fff294ff0
> [226285.156441] RBP: ffff880ff11903b0 R08: 0000000000000001 R09: 000000000000036c
> [226285.156443] R10: ffffffff81c05100 R11: 000000000000036c R12: ffff880ff1190000
> [226285.156444] R13: 000000000000000a R14: 0000000000000202 R15: ffffffff81c05108
> [226285.156446] FS:  0000000000000000(0000) GS:ffff880fff280000(0000) knlGS:0000000000000000
> [226285.156447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [226285.156448] CR2: 0000000000310c00 CR3: 0000000001c0a003 CR4: 00000000000226a0
> [226285.156449] Call Trace:
> [226285.156452]  <IRQ>
> [226285.156456]  ? qdisc_reset+0xe0/0xe0
> [226285.156460]  call_timer_fn+0x13/0x80
> [226285.156462]  expire_timers+0x70/0x80
> [226285.156464]  run_timer_softirq+0x7e/0x150
> [226285.156467]  ? __hrtimer_run_queues+0x130/0x190
> [226285.156471]  ? recalibrate_cpu_khz+0x10/0x10
> [226285.156474]  ? ktime_get+0x33/0x90
> [226285.156477]  ? default_inquire_remote_apic+0x10/0x10
> [226285.156481]  ? lapic_next_event+0x17/0x20
> [226285.156485]  __do_softirq+0xd4/0x1c9
> [226285.156488]  irq_exit+0xa7/0xb0
> [226285.156490]  smp_apic_timer_interrupt+0x59/0x90
> [226285.156492]  apic_timer_interrupt+0xf/0x20
> [226285.156493]  </IRQ>
> [226285.156496] RIP: 0010:acpi_idle_do_entry+0x2b/0x40
> [226285.156496] Code: b6 47 08 3c 01 74 25 3c 02 74 0d 8b 57 04 ec 48 8b 15 fd 8f ac 00 ed c3 65 48 8b 04 25 40 4c 01 00 48 8b 00 a8 08 75 ef fb f4 <fa> c3 e9 ae fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41
> [226285.156522] RSP: 0018:ffffc900000cbe48 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [226285.156524] RAX: 0000000080000000 RBX: ffff880ff83bf400 RCX: 0000000000000034
> [226285.156525] RDX: 4ec4ec4ec4ec4ec5 RSI: ffffffff81c386e0 RDI: ffff880ff83bf464
> [226285.156526] RBP: ffff880ff83bf464 R08: ffff880fff29e1c8 R09: 0000000000000008
> [226285.156527] R10: 0000000000000003 R11: 0000000000000009 R12: 0000000000000001
> [226285.156528] R13: 0000000000000001 R14: 0000000000000001 R15: ffff880ff8c9de80
> [226285.156532]  acpi_idle_enter+0x8d/0x250
> [226285.156536]  ? menu_select+0x399/0x550
> [226285.156537]  cpuidle_enter_state+0xff/0x200
> [226285.156541]  do_idle+0x113/0x200
> [226285.156543]  cpu_startup_entry+0x6a/0x70
> [226285.156545]  start_secondary+0x183/0x1b0
> [226285.156547]  secondary_startup_64+0xa5/0xb0
> [226285.156549] ---[ end trace 66fae9a7fe07d63b ]---
> [226285.156564] igb 0000:08:00.0 eth0: Reset adapter
> [226288.173886] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
