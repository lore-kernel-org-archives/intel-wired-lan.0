From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:23 -0700
Subject: [Intel-wired-lan] [PATCH S44 11/14] ice: cleanup VSI context
 initialization
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Remove an unnecessary copy of vsi->info into ctxt->info in ice_vsi_init.
This line is essentially a no-op because ice_set_dflt_vsi_ctx performs
a memset to clear the info from the context structure.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9bee0d947651..7ab7408b3a05 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -949,7 +949,6 @@ static int ice_vsi_init(struct ice_vsi *vsi, bool init_vsi)
 	if (!ctxt)
 		return -ENOMEM;
 
-	ctxt->info = vsi->info;
 	switch (vsi->type) {
 	case ICE_VSI_CTRL:
 	case ICE_VSI_LB:
-- 
2.20.1

