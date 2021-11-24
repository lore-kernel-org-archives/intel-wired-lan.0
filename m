From: Shiraz Saleem <shiraz.saleem@intel.com>
Date: Wed, 24 Nov 2021 06:41:35 -0600
Subject: [Intel-wired-lan] [PATCH 1/2] net/ice: Fix boolean assignment
Message-ID: <20211124124136.1776-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Shiraz Saleem" <shiraz.saleem@intel.com>

vbool in ice_devlink_enable_roce_get can be assigned to a
non-0/1 constant.

Fix this assignment of vbool to be 0/1.

Fixes: e523af4ee560 ("net/ice: Add support for enable_iwarp and enable_roce devlink param")
Suggested-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 478412b..1cfe918 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -436,7 +436,7 @@ static int ice_devlink_info_get(struct devlink *devlink,
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 
-	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2;
+	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ? true : false;
 
 	return 0;
 }
-- 
1.8.3.1

