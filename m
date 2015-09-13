From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 13 Sep 2015 14:15:13 +0200
Subject: [Intel-wired-lan] [PATCH 20/39] ixgbe: drop null test before
	destroy functions
In-Reply-To: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1442146532-9100-21-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove unneeded NULL test.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ expression x; @@
-if (x != NULL)
  \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 631c603..5f98870 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -620,8 +620,7 @@ static void ixgbe_fcoe_dma_pool_free(struct ixgbe_fcoe *fcoe, unsigned int cpu)
 	struct ixgbe_fcoe_ddp_pool *ddp_pool;
 
 	ddp_pool = per_cpu_ptr(fcoe->ddp_pool, cpu);
-	if (ddp_pool->pool)
-		dma_pool_destroy(ddp_pool->pool);
+	dma_pool_destroy(ddp_pool->pool);
 	ddp_pool->pool = NULL;
 }
 

