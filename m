From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Thu, 22 Jun 2017 10:12:11 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: remove unnecessary
	__packed
Message-ID: <1498151531-18508-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is similar to 'commit 9588397d24eec ("i40e: remove unnecessary
__packed")' to avoid unaligned access.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_osdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
index 5e314fd..a907377 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_osdep.h
@@ -54,7 +54,7 @@ struct i40e_dma_mem {
 	void *va;
 	dma_addr_t pa;
 	u32 size;
-} __packed;
+};
 
 #define i40e_allocate_dma_mem(h, m, unused, s, a) \
 	i40evf_allocate_dma_mem_d(h, m, s, a)
@@ -63,7 +63,7 @@ struct i40e_dma_mem {
 struct i40e_virt_mem {
 	void *va;
 	u32 size;
-} __packed;
+};
 #define i40e_allocate_virt_mem(h, m, s) i40evf_allocate_virt_mem_d(h, m, s)
 #define i40e_free_virt_mem(h, m) i40evf_free_virt_mem_d(h, m)
 
-- 
1.9.1

