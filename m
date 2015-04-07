From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:36 -0400
Subject: [Intel-wired-lan] [net-next S3 07/13] i40e: print FCoE capability
	reported by the device function
In-Reply-To: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450342-48517-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vasu Dev <vasu.dev@intel.com>

This is to allow quick check for FCoE capability is enabled or not
in device function before any SW overrides.

Signed-off-by: Vasu Dev <vasu.dev@intel.com>
Change-ID: I5f78ba798d566f143161273156916c6f4074496e
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index d596f66..44dc4b1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2546,6 +2546,9 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 		}
 	}
 
+	if (p->fcoe)
+		i40e_debug(hw, I40E_DEBUG_ALL, "device is FCoE capable\n");
+
 	/* Software override ensuring FCoE is disabled if npar or mfp
 	 * mode because it is not supported in these modes.
 	 */
-- 
1.9.3

