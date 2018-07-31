From: Basierski, SebastianX <sebastianx.basierski@intel.com>
Date: Tue, 31 Jul 2018 10:31:52 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC
 with GFP_KERNEL
In-Reply-To: <20180727082231.3798-1-baijiaju1990@gmail.com>
References: <20180727082231.3798-1-baijiaju1990@gmail.com>
Message-ID: <3A7E81AC661B4646A4CE6F2E09B7B74E05C6434C@HASMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Acked-by: Sebastian Basierski <sebastianx.basierski@intel.com>

Pozdrawiam
Sebastian Basierski
SII Engineer
Delivering outsourced services to Intel
e-mail: sebastianx.basierski at intel.com




-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Jia-Ju Bai
Sent: Friday, July 27, 2018 10:23 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: netdev at vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>; intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC with GFP_KERNEL

ixgbe_fcoe_ddp_setup(), ixgbe_setup_fcoe_ddp_resources() and
ixgbe_sw_init() are never called in atomic context.
They call kmalloc(), dma_pool_alloc() and kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 4 ++--  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 7a09a40e4472..ff7ed77ce224 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -217,7 +217,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	}
 
 	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
 		goto out_noddp_unmap;
@@ -785,7 +785,7 @@ int ixgbe_setup_fcoe_ddp_resources(struct ixgbe_adapter *adapter)
 		return 0;
 
 	/* Extra buffer to be shared by all DDPs for HW work around */
-	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_ATOMIC);
+	buffer = kmalloc(IXGBE_FCBUFF_MIN, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..fe4a6125576d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6138,7 +6138,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 
 	adapter->mac_table = kzalloc(sizeof(struct ixgbe_mac_addr) *
 				     hw->mac.num_rar_entries,
-				     GFP_ATOMIC);
+				     GFP_KERNEL);
 	if (!adapter->mac_table)
 		return -ENOMEM;
 
--
2.17.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
