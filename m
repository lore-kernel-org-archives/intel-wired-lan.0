From: Daniel J Blueman <daniel@numascale.com>
Date: Wed, 23 Dec 2015 18:01:41 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use core to device locality
	interface
In-Reply-To: <1450864901-16712-1-git-send-email-daniel@numascale.com>
References: <1450864901-16712-1-git-send-email-daniel@numascale.com>
Message-ID: <1450864901-16712-2-git-send-email-daniel@numascale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rather than assuming cores starting from 0 are local to the ethernet
device, use the introduced interface to find near cores.

Not only does this improve performance due to spreading interrupts via near
NUMA nodes, it prevents assigning cores on distant NUMA nodes, which aren't
reachable by device interrupts due to the 8-bit APIC ID limitation.

With Numascale NumaConnect2 systems with Intel ixgbe cards on
non-primary PCI domains, all ixgbe NICs would previously revector
interrupts to cores 0 to 63 (cores 0 to 47 would be considered
near the primary PCI domain). Now, cores 48 to 95 are used, increasing
performance and addressing interrupt delivery issues:

do_IRQ: 79.180 No irq handler for vector (irq -1)
do_IRQ: 78.42 No irq handler for vector (irq -1)
do_IRQ: 71.172 No irq handler for vector (irq -1)
do_IRQ: 70.236 No irq handler for vector (irq -1)
do_IRQ: 69.109 No irq handler for vector (irq -1)
do_IRQ: 68.189 No irq handler for vector (irq -1)
do_IRQ: 72.92 No irq handler for vector (irq -1)
do_IRQ: 73.235 No irq handler for vector (irq -1)
do_IRQ: 66.185 No irq handler for vector (irq -1)
do_IRQ: 67.62 No irq handler for vector (irq -1)
do_IRQ: 197 callbacks suppressed

Signed-off-by: Daniel J Blueman <daniel@numascale.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index f3168bc..12c4ce1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -817,10 +817,8 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	if ((tcs <= 1) && !(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)) {
 		u16 rss_i = adapter->ring_feature[RING_F_RSS].indices;
 		if (rss_i > 1 && adapter->atr_sample_rate) {
-			if (cpu_online(v_idx)) {
-				cpu = v_idx;
-				node = cpu_to_node(cpu);
-			}
+			cpu = cpu_near_dev(adapter->pdev, v_idx);
+			node = cpu_to_node(cpu);
 		}
 	}

--
2.5.0

