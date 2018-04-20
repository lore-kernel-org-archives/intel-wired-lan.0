From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:35 -0700
Subject: [Intel-wired-lan] [next PATCH S90 3/8] i40e: Add advertising 10G LR
 mode
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <20180420084140.8081-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jakub Pawlak <jakub.pawlak@intel.com>

The advertising 10G LR mode should be possible to set
but in the function i40e_set_link_ksettings() check for this
is missed. This patch adds check for 10000baseLR_Full
flag for 10G modes.

Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c1bbfb9..fc6a5ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -953,7 +953,9 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  10000baseCR_Full) ||
 	    ethtool_link_ksettings_test_link_mode(ks, advertising,
-						  10000baseSR_Full))
+						  10000baseSR_Full) ||
+	    ethtool_link_ksettings_test_link_mode(ks, advertising,
+						  10000baseLR_Full))
 		config.link_speed |= I40E_LINK_SPEED_10GB;
 	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
 						  20000baseKR2_Full))
-- 
2.9.5

