From: Jan Sokolowski <jan.sokolowski@intel.com>
Date: Tue, 18 Dec 2018 13:45:13 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] xsk: export xdp_get_umem_from_qid
Message-ID: <20181218134514.6388-1-jan.sokolowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Export xdp_get_umem_from_qid for other modules to use.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 net/xdp/xdp_umem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index a264cf2accd0..424ae2538f9f 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -60,6 +60,7 @@ struct xdp_umem *xdp_get_umem_from_qid(struct net_device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL(xdp_get_umem_from_qid);
 
 static void xdp_clear_umem_at_qid(struct net_device *dev, u16 queue_id)
 {
-- 
2.18.1

