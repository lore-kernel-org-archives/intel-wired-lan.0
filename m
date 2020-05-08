From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:11 -0700
Subject: [Intel-wired-lan] [PATCH S41 13/15] ice: remove unnecessary check
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The variable status cannot be zero due to a prior check of it; remove this
check.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d9ffa48b3dd4..d2152cd22b5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -150,7 +150,7 @@ static int ice_init_mac_fltr(struct ice_pf *pf)
 	/* We aren't useful with no MAC filters, so unregister if we
 	 * had an error
 	 */
-	if (status && vsi->netdev->reg_state == NETREG_REGISTERED) {
+	if (vsi->netdev->reg_state == NETREG_REGISTERED) {
 		dev_err(ice_pf_to_dev(pf), "Could not add MAC filters error %s. Unregistering device\n",
 			ice_stat_str(status));
 		unregister_netdev(vsi->netdev);
-- 
2.20.1

