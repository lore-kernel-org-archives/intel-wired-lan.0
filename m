From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:40 -0800
Subject: [Intel-wired-lan] [FIXUP PATCH 2/2] fixup! i40e: Add support for
	exposing VF port statistics via VFPR netdev on the host
In-Reply-To: <20170206223840.30938-1-jacob.e.keller@intel.com>
References: <20170206223840.30938-1-jacob.e.keller@intel.com>
Message-ID: <20170206223840.30938-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes a compiler warning in commit abc0e7634722 ("i40e: Add support
for exposing VF port statistics via VFPR netdev on the host",
2017-01-31) which is caused by a function that should have been marked
as static.

Jeff, please squash this patch into the given commit, or have the
original author re-roll his patch to fix the warning.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9efecff9c535..2686ddd65618 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1062,7 +1062,7 @@ static int i40e_vfpr_netdev_stop(struct net_device *dev)
  *
  * Fills the hw statistics from the VSI corresponding to the associated VFPR
  **/
-void
+static void
 i40e_vfpr_netdev_get_stats64(struct net_device *netdev,
 			     struct rtnl_link_stats64 *stats)
 {
-- 
2.12.0.rc0.151.g8a5726c42288

