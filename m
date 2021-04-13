From: Salil Mehta <salil.mehta@huawei.com>
Date: Tue, 13 Apr 2021 23:44:46 +0100
Subject: [Intel-wired-lan] [PATCH V2 net] ice: Re-organizes reqstd/avail {R,
 T}XQ check/code for efficiency+readability
Message-ID: <20210413224446.16612-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If user has explicitly requested the number of {R,T}XQs, then it is
unnecessary to get the count of already available {R,T}XQs from the
PF avail_{r,t}xqs bitmap. This value will get overridden by user specified
value in any case.

This patch does minor re-organization of the code for improving the flow
and readabiltiy. This scope of improvement was found during the review of
the ICE driver code.

FYI, I could not test this change due to unavailability of the hardware.
It would be helpful if somebody can test this patch and provide Tested-by
Tag. Many thanks!

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Cc: intel-wired-lan at lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
--
Change V1->V2
 (*) Fixed the comments from Anthony Nguyen(Intel)
     Link: https://lkml.org/lkml/2021/4/12/1997
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d13c7fc8fb0a..d77133d6baa7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -161,12 +161,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
 
 	switch (vsi->type) {
 	case ICE_VSI_PF:
-		vsi->alloc_txq = min3(pf->num_lan_msix,
-				      ice_get_avail_txq_count(pf),
-				      (u16)num_online_cpus());
 		if (vsi->req_txq) {
 			vsi->alloc_txq = vsi->req_txq;
 			vsi->num_txq = vsi->req_txq;
+		} else {
+			vsi->alloc_txq = min3(pf->num_lan_msix,
+					      ice_get_avail_txq_count(pf),
+					      (u16)num_online_cpus());
 		}
 
 		pf->num_lan_tx = vsi->alloc_txq;
@@ -175,12 +176,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
 		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
 			vsi->alloc_rxq = 1;
 		} else {
-			vsi->alloc_rxq = min3(pf->num_lan_msix,
-					      ice_get_avail_rxq_count(pf),
-					      (u16)num_online_cpus());
 			if (vsi->req_rxq) {
 				vsi->alloc_rxq = vsi->req_rxq;
 				vsi->num_rxq = vsi->req_rxq;
+			} else {
+				vsi->alloc_rxq = min3(pf->num_lan_msix,
+						      ice_get_avail_rxq_count(pf),
+						      (u16)num_online_cpus());
 			}
 		}
 
-- 
2.17.1

