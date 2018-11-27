From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 27 Nov 2018 09:35:35 -0800
Subject: [Intel-wired-lan] [PATCH v2] i40e: fix kerneldoc for xsk methods
Message-ID: <20181127173536.7501-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

One method, xsk_umem_setup, had an incorrect kernel doc
description, which has been corrected.

Also fixes small typos found in the comments.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
v2: fixed patch corruption possibly caused by internal mail server

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index add1e457886d..433c8e688c78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -33,7 +33,7 @@ static int i40e_alloc_xsk_umems(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_add_xsk_umem - Store an UMEM for a certain ring/qid
+ * i40e_add_xsk_umem - Store a UMEM for a certain ring/qid
  * @vsi: Current VSI
  * @umem: UMEM to store
  * @qid: Ring/qid to associate with the UMEM
@@ -56,7 +56,7 @@ static int i40e_add_xsk_umem(struct i40e_vsi *vsi, struct xdp_umem *umem,
 }
 
 /**
- * i40e_remove_xsk_umem - Remove an UMEM for a certain ring/qid
+ * i40e_remove_xsk_umem - Remove a UMEM for a certain ring/qid
  * @vsi: Current VSI
  * @qid: Ring/qid associated with the UMEM
  **/
@@ -130,7 +130,7 @@ static void i40e_xsk_umem_dma_unmap(struct i40e_vsi *vsi, struct xdp_umem *umem)
 }
 
 /**
- * i40e_xsk_umem_enable - Enable/associate an UMEM to a certain ring/qid
+ * i40e_xsk_umem_enable - Enable/associate a UMEM to a certain ring/qid
  * @vsi: Current VSI
  * @umem: UMEM
  * @qid: Rx ring to associate UMEM to
@@ -189,7 +189,7 @@ static int i40e_xsk_umem_enable(struct i40e_vsi *vsi, struct xdp_umem *umem,
 }
 
 /**
- * i40e_xsk_umem_disable - Diassociate an UMEM from a certain ring/qid
+ * i40e_xsk_umem_disable - Disassociate a UMEM from a certain ring/qid
  * @vsi: Current VSI
  * @qid: Rx ring to associate UMEM to
  *
@@ -255,12 +255,12 @@ int i40e_xsk_umem_query(struct i40e_vsi *vsi, struct xdp_umem **umem,
 }
 
 /**
- * i40e_xsk_umem_query - Queries a certain ring/qid for its UMEM
+ * i40e_xsk_umem_setup - Enable/disassociate a UMEM to/from a ring/qid
  * @vsi: Current VSI
  * @umem: UMEM to enable/associate to a ring, or NULL to disable
  * @qid: Rx ring to (dis)associate UMEM (from)to
  *
- * This function enables or disables an UMEM to a certain ring.
+ * This function enables or disables a UMEM to a certain ring.
  *
  * Returns 0 on success, <0 on failure
  **/
@@ -276,7 +276,7 @@ int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
  * @rx_ring: Rx ring
  * @xdp: xdp_buff used as input to the XDP program
  *
- * This function enables or disables an UMEM to a certain ring.
+ * This function enables or disables a UMEM to a certain ring.
  *
  * Returns any of I40E_XDP_{PASS, CONSUMED, TX, REDIR}
  **/
-- 
2.19.1

