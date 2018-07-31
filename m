From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:44 -0700
Subject: [Intel-wired-lan] [next PATCH S93 07/11] i40e: remove unnecessary i
 variable causing -Wshadow warning
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Commit c61c8fe1d592 ("i40e: Implement an ethtool private flag to stop
LLDP in FW") added an extra for-loop which added a shadowing 'i'
variable as the index.

However, the local variable i already exists, and we already use it as
a loop index. Additionally, at this point, there is no further use of
the variable, so it's safe to simply overwrite the variable contents.

This fixes a -Wshadow warning which has started being enabled on some
distributions

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Malek, Patryk <patryk.malek@intel.com>
Change-ID: I1d2259d27ccab6927efd40fb1853af74678680b8
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9c380c0..12d279a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4642,7 +4642,6 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
 		if (pf->flags & I40E_FLAG_DISABLE_FW_LLDP) {
 			struct i40e_dcbx_config *dcbcfg;
-			int i;
 
 			i40e_aq_stop_lldp(&pf->hw, true, NULL);
 			i40e_aq_set_dcb_parameters(&pf->hw, true, NULL);
-- 
2.9.5

