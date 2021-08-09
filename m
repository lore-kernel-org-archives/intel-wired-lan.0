From: Venkataramanan, Anirudh <anirudh.venkataramanan@intel.com>
Date: Mon, 9 Aug 2021 14:22:46 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add locking to prevent panic
 when setting sriov_numvfs to zero.
In-Reply-To: <20210809125003.679140-1-jkc@redhat.com>
References: <20210809125003.679140-1-jkc@redhat.com>
Message-ID: <3c15dd1fe7eb55bf144e9034d877c366d5871654.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-08-09 at 07:50 -0500, Ken Cox wrote:
> It is possible to disable VFs while the PF driver is processing
> requests
> from the VF driver.? This can result in a panic.
> 
> BUG: unable to handle kernel paging request at 000000000000106c
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 8 PID: 0 Comm: swapper/8 Kdump: loaded Tainted: G????????? I?????
> --------- -? -
> Hardware name: Dell Inc. PowerEdge R740/06WXJT, BIOS 2.8.2 08/27/2020
> RIP: 0010:ixgbe_msg_task+0x4c8/0x1690 [ixgbe]
> Code: 00 00 48 8d 04 40 48 c1 e0 05 89 7c 24 24 89 fd 48 89 44 24 10 83
> ff 01 0f 84 b8 04 00 00 4c 8b 64 24 10 4d 03 a5 48 22 00 00 <41> 80 7c
> 24 4c 00 0f 84 8a 03 00 00 0f b7 c7 83 f8 08 0f 84 8f 0a
> RSP: 0018:ffffb337869f8df8 EFLAGS: 00010002
> RAX: 0000000000001020 RBX: 0000000000000000 RCX: 000000000000002b
> RDX: 0000000000000002 RSI: 0000000000000008 RDI: 0000000000000006
> RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000029780
> R10: 00006957d8f42832 R11: 0000000000000000 R12: 0000000000001020
> R13: ffff8a00e8978ac0 R14: 000000000000002b R15: ffff8a00e8979c80
> FS:? 0000000000000000(0000) GS:ffff8a07dfd00000(0000)
> knlGS:0000000000000000
> CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000106c CR3: 0000000063e10004 CR4: 00000000007726e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> ?<IRQ>
> ?? ttwu_do_wakeup+0x19/0x140
> ?? try_to_wake_up+0x1cd/0x550
> ?? ixgbevf_update_xcast_mode+0x71/0xc0 [ixgbevf]
> ?ixgbe_msix_other+0x17e/0x310 [ixgbe]
> ?__handle_irq_event_percpu+0x40/0x180
> ?handle_irq_event_percpu+0x30/0x80
> ?handle_irq_event+0x36/0x53
> ?handle_edge_irq+0x82/0x190
> ?handle_irq+0x1c/0x30
> ?do_IRQ+0x49/0xd0
> ?common_interrupt+0xf/0xf
> 
> This can be eventually be reproduced with the following script:
> 
> while :
> do
> ????????echo 63 > /sys/class/net/ens3f0/device/sriov_numvfs
> ????????sleep 1
> ????????echo 0 > /sys/class/net/ens3f0/device/sriov_numvfs
> ??????? sleep 1
> done
> 
> Signed-off-by: Ken Cox <jkc@redhat.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe.h?????? | 1 +
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 9 +++++++++
> ?2 files changed, 10 insertions(+)
> 

Acked-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
