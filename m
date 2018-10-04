From: Alice Michael <alice.michael@intel.com>
Date: Thu,  4 Oct 2018 15:18:28 -0700
Subject: [Intel-wired-lan] [next PATCH S97 5/7] i40e: Remove negated logic
 in if statement and fix comment
In-Reply-To: <20181004221830.16212-1-alice.michael@intel.com>
References: <20181004221830.16212-1-alice.michael@intel.com>
Message-ID: <20181004221830.16212-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

Found by upstream review.  It also fixes a minor comment formatting
to adhere to networking comment formatting.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f35a26c..2bb116f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4958,8 +4958,8 @@ void i40e_set_ethtool_ops(struct net_device *netdev)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf		*pf = np->vsi->back;
 
-	if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
-		netdev->ethtool_ops = &i40e_ethtool_ops;
-	else
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
 		netdev->ethtool_ops = &i40e_ethtool_recovery_mode_ops;
+	else
+		netdev->ethtool_ops = &i40e_ethtool_ops;
 }
-- 
2.9.5

