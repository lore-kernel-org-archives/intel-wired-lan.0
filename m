From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 14 Sep 2019 08:20:57 -0700
Subject: [Intel-wired-lan] e1000e: workqueue problem
Message-ID: <d7094fb6-7cc4-4e79-d74f-27fe078fbba7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is 5.30-rc8 on x86_64.

I would be happy to hear if this has already been addressed in some of
your recent patches.

Or:  this could be a PCI-related or workqueue bug, but it only shows up
when loading the e1000e driver.  And not every time.



[  623.410732] calling  e1000_init_module+0x0/0x1000 [e1000e] @ 11258
[  623.410768] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[  623.410792] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[  623.420492] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[  623.529922] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[  623.631604] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) e8:9d:87:4a:c2:2d
[  623.631670] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[  623.631774] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: FFFFFF-0FF
[  623.632021] probe of 0000:00:19.0 returned 1 after 221138 usecs
[  623.632520] initcall e1000_init_module+0x0/0x1000 [e1000e] returned 0 after 216532 usecs
[  623.752736] e1000e 0000:00:19.0 eth0: removed PHC
[  623.920346] ==================================================================
[  623.920389] BUG: KASAN: use-after-free in __queue_work+0x98d/0xcb0
[  623.920414] Read of size 4 at addr ffff8881127b12a8 by task swapper/3/0

[  623.920452] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.3.0-rc8 #2
[  623.920476] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  623.920504] Call Trace:
[  623.920520]  <IRQ>
[  623.920538]  dump_stack+0x7b/0xb5
[  623.920559]  print_address_description+0x6e/0x470
[  623.920586]  __kasan_report+0x11a/0x198
[  623.920606]  ? sched_clock_cpu+0x1b/0x1e0
[  623.920625]  ? __queue_work+0x98d/0xcb0
[  623.920647]  ? __queue_work+0x98d/0xcb0
[  623.920668]  kasan_report+0x12/0x20
[  623.920687]  __asan_report_load4_noabort+0x14/0x20
[  623.920708]  __queue_work+0x98d/0xcb0
[  623.920736]  delayed_work_timer_fn+0x58/0x90
[  623.920759]  call_timer_fn.isra.21+0x19f/0x2e0
[  623.920778]  ? call_timer_fn.isra.21+0x16c/0x2e0
[  623.920799]  ? queue_work_node+0x370/0x370
[  623.920819]  ? del_timer+0xe0/0xe0
[  623.920844]  ? __kasan_check_read+0x11/0x20
[  623.920865]  ? do_raw_spin_unlock+0x54/0x220
[  623.920889]  run_timer_softirq+0x4d9/0xe70
[  623.920910]  ? lock_acquire+0xd2/0x180
[  623.920931]  ? queue_work_node+0x370/0x370
[  623.920952]  ? trigger_dyntick_cpu+0x290/0x290
[  623.920974]  ? sched_clock+0x9/0x10
[  623.920992]  ? sched_clock+0x9/0x10
[  623.921011]  ? sched_clock_cpu+0x1b/0x1e0
[  623.921031]  ? lapic_next_deadline+0x21/0x30
[  623.921052]  ? clockevents_program_event+0x264/0x350
[  623.921082]  __do_softirq+0x1c8/0x623
[  623.921109]  irq_exit+0x1c8/0x210
[  623.921128]  smp_apic_timer_interrupt+0xd1/0x130
[  623.921151]  apic_timer_interrupt+0xf/0x20
[  623.921170]  </IRQ>
[  623.921185] RIP: 0010:cpuidle_enter_state+0x11a/0xbb0
[  623.921207] Code: 80 7d d0 00 8b 4d c8 74 1d 9c 58 66 66 90 66 90 f6 c4 02 0f 85 6d 05 00 00 31 ff 89 4d d0 e8 1d 59 80 fe 8b 4d d0 fb 66 66 90 <66> 66 90 85 c9 79 47 49 8d 7d 10 48 b8 00 00 00 00 00 fc ff df 48
[  623.921263] RSP: 0018:ffff888107f67cd8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[  623.921291] RAX: dffffc0000000000 RBX: ffffffffb4770958 RCX: 0000000000000005
[  623.921317] RDX: 1ffff110238fef99 RSI: 000000003574540e RDI: ffff88811c7f7cc8
[  623.921343] RBP: ffff888107f67d38 R08: 0000000000000002 R09: ffffed1020feb691
[  623.921369] R10: ffff888107f67c70 R11: ffffed1020feb690 R12: ffffffffb4770760
[  623.921394] R13: ffffe8fffea03158 R14: 0000009144892b23 R15: 00000091447a7ab5
[  623.921433]  ? cpuidle_enter_state+0xf0/0xbb0
[  623.921456]  ? menu_enable_device+0x170/0x170
[  623.921480]  cpuidle_enter+0x4a/0xa0
[  623.921499]  ? __kasan_check_write+0x14/0x20
[  623.921521]  call_cpuidle+0x68/0xc0
[  623.921542]  do_idle+0x31d/0x3e0
[  623.921559]  ? apic_timer_interrupt+0xa/0x20
[  623.921582]  ? arch_cpu_idle_exit+0x40/0x40
[  623.921611]  cpu_startup_entry+0x18/0x20
[  623.921631]  start_secondary+0x338/0x430
[  623.921652]  ? set_cpu_sibling_map+0x37e0/0x37e0
[  623.921686]  secondary_startup_64+0xa4/0xb0

[  623.921730] Allocated by task 11258:
[  623.921748]  save_stack+0x21/0x90
[  623.921765]  __kasan_kmalloc.constprop.8+0xa7/0xd0
[  623.921786]  kasan_kmalloc+0x9/0x10
[  623.921804]  alloc_workqueue+0x122/0xe30
[  623.921831]  e1000_probe+0x1c4c/0x4550 [e1000e]
[  623.921853]  local_pci_probe+0xd9/0x180
[  623.921872]  pci_device_probe+0x340/0x740
[  623.921891]  really_probe+0x516/0xb00
[  623.921909]  driver_probe_device+0xf0/0x3a0
[  623.921928]  device_driver_attach+0xec/0x120
[  623.921947]  __driver_attach+0x108/0x270
[  623.921965]  bus_for_each_dev+0x116/0x1b0
[  623.921983]  driver_attach+0x38/0x50
[  623.922001]  bus_add_driver+0x44e/0x6a0
[  623.922019]  driver_register+0x18e/0x410
[  623.922037]  __pci_register_driver+0x187/0x240
[  623.922058]  0xffffffffc029803d
[  623.922075]  do_one_initcall+0xab/0x2d5
[  623.922106]  do_init_module+0x1c7/0x582
[  623.922138]  load_module+0x4efd/0x5f30
[  623.922170]  __do_sys_finit_module+0x12a/0x1b0
[  623.922193]  __x64_sys_finit_module+0x6e/0xb0
[  623.922212]  do_syscall_64+0xaa/0x380
[  623.922231]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  623.922263] Freed by task 0:
[  623.922279]  save_stack+0x21/0x90
[  623.922296]  __kasan_slab_free+0x137/0x190
[  623.922316]  kasan_slab_free+0xe/0x10
[  623.922333]  kfree+0xb8/0x210
[  623.922349]  rcu_free_wq+0xd5/0x130
[  623.922367]  rcu_core+0x478/0xfa0
[  623.922383]  rcu_core_si+0x9/0x10
[  623.922400]  __do_softirq+0x1c8/0x623

[  623.922429] The buggy address belongs to the object at ffff8881127b10e8
                which belongs to the cache kmalloc-512 of size 512
[  623.922472] The buggy address is located 448 bytes inside of
                512-byte region [ffff8881127b10e8, ffff8881127b12e8)
[  623.922511] The buggy address belongs to the page:
[  623.922532] page:ffffea000449ec00 refcount:1 mapcount:0 mapping:ffff888107c11300 index:0x0 compound_mapcount: 0
[  623.922567] flags: 0x17ffffc0010200(slab|head)
[  623.922589] raw: 0017ffffc0010200 ffffea000442c008 ffffea000442da08 ffff888107c11300
[  623.922617] raw: 0000000000000000 0000000000250025 00000001ffffffff 0000000000000000
[  623.922644] page dumped because: kasan: bad access detected

[  623.922676] Memory state around the buggy address:
[  623.922697]  ffff8881127b1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  623.922723]  ffff8881127b1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  623.922749] >ffff8881127b1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
[  623.922775]                                   ^
[  623.922794]  ffff8881127b1300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  623.922820]  ffff8881127b1380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  623.922845] ==================================================================
[  623.922870] Disabling lock debugging due to kernel taint
[  624.029500] e1000e: eth0 NIC Link is Down

-- 
~Randy
