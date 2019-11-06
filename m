From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  6 Nov 2019 02:05:30 -0800
Subject: [Intel-wired-lan] [PATCH S32 v3 04/15] ice: avoid setting features
 during reset
In-Reply-To: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
Message-ID: <20191106100541.48639-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Certain subsystems behave very badly when called during reset (core
dump). This patch returns -EBUSY when reconfiguring some subsystems
during reset. With this patch some ethtool functions will not core
dump during reset.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a0a04114d991..94354b307a4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3924,6 +3924,7 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
 	int ret = 0;
 
 	/* Don't set any netdev advanced features with device in Safe Mode */
@@ -3933,6 +3934,13 @@ ice_set_features(struct net_device *netdev, netdev_features_t features)
 		return ret;
 	}
 
+	/* Do not change setting during reset */
+	if (ice_is_reset_in_progress(pf->state)) {
+		dev_err(&vsi->back->pdev->dev,
+			"Device is resetting, changing advanced netdev features temporarily unavailable.\n");
+		return -EBUSY;
+	}
+
 	/* Multiple features can be changed in one call so keep features in
 	 * separate if/else statements to guarantee each feature is checked
 	 */
-- 
2.20.1

