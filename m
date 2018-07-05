From: Marco Berizzi <pupilla@libero.it>
Date: Thu, 5 Jul 2018 15:22:23 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.17
In-Reply-To: <528200032.321946.1528186357567@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
Message-ID: <963322856.1365958.1530796944033@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 5 giugno 2018 alle 10.12 Marco Berizzi <pupilla@libero.it> ha scritto:
> 
> Hi Folks,
> 
> after upgrading from 4.16.13 to 4.17 I got this error message.
> 
> Any feedback are welcome.
> 
> Marco Berizzi
> 
> PS: this system is running oracle virtualbox 5.2.12

Hi Folks,

I'm getting the same error also with 4.17.3:

[717164.170363] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <1>
                  TDH                  <e1>
                  TDT                  <e1>
                  next_to_use          <e2>
                  next_to_clean        <e1>
                buffer_info[next_to_clean]
                  time_stamp           <12aba9c00>
                  next_to_watch        <0000000048469c50>
                  jiffies              <12abaa000>
                  desc.status          <a8010>
[717166.154208] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <1>
                  TDH                  <e1>
                  TDT                  <e1>
                  next_to_use          <e2>
                  next_to_clean        <e1>
                buffer_info[next_to_clean]
                  time_stamp           <12aba9c00>
                  next_to_watch        <0000000048469c50>
                  jiffies              <12abaa7c0>
                  desc.status          <a8010>
[717168.139178] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <1>
                  TDH                  <e1>
                  TDT                  <e1>
                  next_to_use          <e2>
                  next_to_clean        <e1>
                buffer_info[next_to_clean]
                  time_stamp           <12aba9c00>
                  next_to_watch        <0000000048469c50>
                  jiffies              <12abaaf81>
                  desc.status          <a8010>
[717170.122069] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <1>
                  TDH                  <e1>
                  TDT                  <e1>
                  next_to_use          <e2>
                  next_to_clean        <e1>
                buffer_info[next_to_clean]
                  time_stamp           <12aba9c00>
                  next_to_watch        <0000000048469c50>
                  jiffies              <12abab740>
                  desc.status          <a8010>
[717172.171042] igb 0000:08:00.0: Detected Tx Unit Hang
                  Tx Queue             <1>
                  TDH                  <e1>
                  TDT                  <e1>
                  next_to_use          <e2>
                  next_to_clean        <e1>
                buffer_info[next_to_clean]
                  time_stamp           <12aba9c00>
                  next_to_watch        <0000000048469c50>
                  jiffies              <12ababf41>
                  desc.status          <a8010>
[717172.362925] ------------[ cut here ]------------
[717172.362930] NETDEV WATCHDOG: eth0 (igb): transmit queue 1 timed out
[717172.362952] WARNING: CPU: 10 PID: 0 at net/sched/sch_generic.c:473 dev_watchdog+0x1d9/0x1e0
[717172.362953] Modules linked in: mousedev hid_generic usbhid hid vboxpci(O) vboxnetflt(O) vboxnetadp(O) vboxdrv(O) igb uhci_hcd 8250 ptp evdev button ehci_pci 8250_base pps_core ehci_hcd i2c_i801 i2c_algo_bit usbcore i2c_core serial_core usb_common loop
[717172.362978] CPU: 10 PID: 0 Comm: swapper/10 Tainted: G          IO      4.17.3 #1
[717172.362979] Hardware name: FUJITSU                          PRIMERGY RX300 S6             /D2619, BIOS 6.00 Rev. 1.13.2619.N1           01/19/2012
[717172.362982] RIP: 0010:dev_watchdog+0x1d9/0x1e0
[717172.362984] RSP: 0018:ffff880fff283ed0 EFLAGS: 00010282
[717172.362986] RAX: 0000000000000037 RBX: 0000000000000001 RCX: 0000000000000006
[717172.362987] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff880fff294ff0
[717172.362989] RBP: ffff880ff0cd83b0 R08: 0000000000000001 R09: 00000000000003a5
[717172.362990] R10: ffffffff81c05100 R11: 00000000000003a5 R12: ffff880ff0cd8000
[717172.362992] R13: 000000000000000a R14: 0000000000000002 R15: ffffffff81c05108
[717172.362994] FS:  0000000000000000(0000) GS:ffff880fff280000(0000) knlGS:0000000000000000
[717172.362996] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[717172.362997] CR2: 000007fffffab478 CR3: 0000000001c0a005 CR4: 00000000000226a0
[717172.362998] Call Trace:
[717172.363002]  <IRQ>
[717172.363006]  ? qdisc_reset+0xe0/0xe0
[717172.363011]  call_timer_fn+0x13/0x80
[717172.363015]  expire_timers+0x70/0x80
[717172.363017]  run_timer_softirq+0x6e/0x120
[717172.363020]  ? __hrtimer_run_queues+0x130/0x190
[717172.363024]  ? recalibrate_cpu_khz+0x10/0x10
[717172.363027]  ? ktime_get+0x33/0x90
[717172.363030]  ? default_inquire_remote_apic+0x10/0x10
[717172.363034]  ? lapic_next_event+0x17/0x20
[717172.363037]  ? clockevents_program_event+0x7e/0xf0
[717172.363041]  __do_softirq+0xd4/0x1c9
[717172.363045]  irq_exit+0xa3/0xb0
[717172.363047]  smp_apic_timer_interrupt+0x59/0x90
[717172.363050]  apic_timer_interrupt+0xf/0x20
[717172.363051]  </IRQ>
[717172.363057] RIP: 0010:acpi_idle_do_entry+0x2b/0x40
[717172.363058] RSP: 0018:ffffc900000c3e88 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[717172.363061] RAX: 0000000080000000 RBX: ffff880ff7c07400 RCX: 0000000000000034
[717172.363063] RDX: 4ec4ec4ec4ec4ec5 RSI: ffffffff81c37d20 RDI: ffff880ff7c07464
[717172.363064] RBP: ffff880ff7c07464 R08: ffff880fff29e048 R09: 0000000000000018
[717172.363065] R10: 000000000000009d R11: 00000000000000c8 R12: 0000000000000001
[717172.363067] R13: 0000000000000001 R14: 0000000000000001 R15: ffff880ff8c9d200
[717172.363074]  acpi_idle_enter+0x7d/0x220
[717172.363077]  ? menu_select+0x377/0x530
[717172.363082]  cpuidle_enter_state+0xff/0x200
[717172.363086]  do_idle+0x103/0x1d0
[717172.363088]  cpu_startup_entry+0x14/0x20
[717172.363090]  secondary_startup_64+0xa5/0xb0
[717172.363091] Code: 41 00 48 63 4d f0 eb 97 4c 89 e7 c6 05 eb 2a 86 00 01 e8 5b 19 fe ff 89 d9 4c 89 e6 48 c7 c7 58 fc b2 81 48 89 c2 e8 d7 55 c5 ff <0f> 0b eb c0 0f 1f 00 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 
[717172.363118] ---[ end trace 43df48974a590f3d ]---
[717172.363130] igb 0000:08:00.0 eth0: Reset adapter
[717175.512405] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
