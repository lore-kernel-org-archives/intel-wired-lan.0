From: Kielan, Tymoteusz <tymoteusz.kielan@intel.com>
Date: Mon, 30 Jul 2018 16:15:54 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: ixgbe: Replace GFP_ATOMIC
 with GFP_KERNEL
In-Reply-To: <20180727082231.3798-1-baijiaju1990@gmail.com>
References: <20180727082231.3798-1-baijiaju1990@gmail.com>
Message-ID: <37EA2F27FEDED94487ADB266632B54EF73001775@IRSMSX107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

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
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

