From: Tomas Charvat <tc@excello.cz>
Date: Thu, 22 Mar 2018 10:38:58 +0100
Subject: [Intel-wired-lan] 4.14.28 page allocation failure ksoftirqd/0 e1000
Message-ID: <368d2980-ca08-26cd-5ed7-b95bd50602f1@excello.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi I'm not sure whenever this is e1000 issue, however it appear only in
this form.

[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] Mem-Info:
[Thu Mar 22 10:00:08 2018] active_anon:372939 inactive_anon:62
isolated_anon:0
??????????????????????????? active_file:476675 inactive_file:215871
isolated_file:0
??????????????????????????? unevictable:0 dirty:81834 writeback:447
unstable:0
??????????????????????????? slab_reclaimable:142237 slab_unreclaimable:15379
??????????????????????????? mapped:77278 shmem:105 pagetables:9862 bounce:0
??????????????????????????? free:6564 free_pcp:451 free_cma:0
[Thu Mar 22 10:00:08 2018] Node 0 active_anon:1491756kB
inactive_anon:248kB active_file:1906700kB inactive_file:863484kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:309112kB
dirty:327336kB writeback:1788kB shmem:420kB writeback_tmp:0kB
unstable:0kB all_unreclaimable? no
[Thu Mar 22 10:00:08 2018] Node 0 DMA free:15900kB min:28kB low:40kB
high:52kB active_anon:0kB inactive_anon:0kB active_file:0kB
inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB
managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB
free_pcp:0kB local_pcp:0kB free_cma:0kB
[Thu Mar 22 10:00:08 2018] lowmem_reserve[]: 0 3741 4931 4931
[Thu Mar 22 10:00:08 2018] Node 0 DMA32 free:7028kB min:6804kB
low:10632kB high:14460kB active_anon:974436kB inactive_anon:4kB
active_file:1478820kB inactive_file:722488kB unevictable:0kB
writepending:249676kB present:3915772kB managed:3835092kB mlocked:0kB
kernel_stack:4768kB pagetables:21908kB bounce:0kB free_pcp:1184kB
local_pcp:120kB free_cma:0kB
[Thu Mar 22 10:00:08 2018] lowmem_reserve[]: 0 0 1189 1189
[Thu Mar 22 10:00:08 2018] Node 0 Normal free:3328kB min:2164kB
low:3380kB high:4596kB active_anon:517320kB inactive_anon:244kB
active_file:427880kB inactive_file:140996kB unevictable:0kB
writepending:79448kB present:1302528kB managed:1210252kB mlocked:0kB
kernel_stack:4592kB pagetables:17540kB bounce:0kB free_pcp:620kB
local_pcp:28kB free_cma:0kB
[Thu Mar 22 10:00:08 2018] lowmem_reserve[]: 0 0 0 0
[Thu Mar 22 10:00:08 2018] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U)
0*32kB 2*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 1*1024kB (U) 1*2048kB
(U) 3*4096kB (M) = 15900kB
[Thu Mar 22 10:00:08 2018] Node 0 DMA32: 49*4kB (MEH) 36*8kB (UMEH)
25*16kB (MH) 54*32kB (UEH) 39*64kB (UEH) 7*128kB (H) 2*256kB (H) 1*512kB
(H) 0*1024kB 0*2048kB 0*4096kB = 7028kB
[Thu Mar 22 10:00:08 2018] Node 0 Normal: 22*4kB (H) 19*8kB (H) 25*16kB
(H) 14*32kB (H) 9*64kB (H) 5*128kB (H) 4*256kB (H) 0*512kB 0*1024kB
0*2048kB 0*4096kB = 3328kB
[Thu Mar 22 10:00:08 2018] 692651 total pagecache pages
[Thu Mar 22 10:00:08 2018] 0 pages in swap cache
[Thu Mar 22 10:00:08 2018] Swap cache stats: add 0, delete 0, find 0/0
[Thu Mar 22 10:00:08 2018] Free swap? = 0kB
[Thu Mar 22 10:00:08 2018] Total swap = 0kB
[Thu Mar 22 10:00:08 2018] 1308573 pages RAM
[Thu Mar 22 10:00:08 2018] 0 pages HighMem/MovableOnly
[Thu Mar 22 10:00:08 2018] 43260 pages reserved
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x442/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x442/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40
[Thu Mar 22 10:00:08 2018] ksoftirqd/0: page allocation failure:
order:0, mode:0x1080120(GFP_ATOMIC|__GFP_COLD), nodemask=(null)
[Thu Mar 22 10:00:08 2018] CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted
4.14.28-gentoo #2
[Thu Mar 22 10:00:08 2018] Hardware name: Xen HVM domU, BIOS 4.9.1
01/25/2018
[Thu Mar 22 10:00:08 2018] Call Trace:
[Thu Mar 22 10:00:08 2018]? dump_stack+0x5c/0x7e
[Thu Mar 22 10:00:08 2018]? warn_alloc+0x11a/0x1c0
[Thu Mar 22 10:00:08 2018]? __alloc_pages_nodemask+0xb4c/0xd50
[Thu Mar 22 10:00:08 2018]? page_frag_alloc+0x12c/0x160
[Thu Mar 22 10:00:08 2018]? netdev_alloc_frag+0x2d/0x40
[Thu Mar 22 10:00:08 2018]? e1000_alloc_rx_buffers+0xe7/0x490
[Thu Mar 22 10:00:08 2018]? ? netif_receive_skb_internal+0x47/0xf0
[Thu Mar 22 10:00:08 2018]? e1000_clean_rx_irq+0x3a2/0x4d0
[Thu Mar 22 10:00:08 2018]? e1000_clean+0x283/0x8e0
[Thu Mar 22 10:00:08 2018]? net_rx_action+0x206/0x2d0
[Thu Mar 22 10:00:08 2018]? __do_softirq+0xe4/0x1f2
[Thu Mar 22 10:00:08 2018]? run_ksoftirqd+0x20/0x40
[Thu Mar 22 10:00:08 2018]? smpboot_thread_fn+0xfe/0x150
[Thu Mar 22 10:00:08 2018]? kthread+0xf2/0x130
[Thu Mar 22 10:00:08 2018]? ? sort_range+0x20/0x20
[Thu Mar 22 10:00:08 2018]? ? __kthread_create_on_node+0x1a0/0x1a0
[Thu Mar 22 10:00:08 2018]? ret_from_fork+0x35/0x40

Best regards

-- 
Tomas Charvat
EXCELLO | Virusfree
w: www.virusfree.cz
e: tc at excello.cz


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3978 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180322/1d7e7cb0/attachment.p7s>
