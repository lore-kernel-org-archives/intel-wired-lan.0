From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:31 -0700
Subject: [Intel-wired-lan] [PATCH S26 13/15] ice: add print of autoneg state
 to link message
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Print the state of autonegotiation when printing the Link
up message.  Adds new text to the "NIC Link is up" line like
Autoneg: <True | False>

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6b8055ab566f..fb05871dc271 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -626,6 +626,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	const char *speed;
 	const char *fec;
 	const char *fc;
+	const char *an;
 
 	if (!vsi)
 		return;
@@ -709,6 +710,12 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 		break;
 	}
 
+	/* check if autoneg completed, might be false due to not supported */
+	if (vsi->port_info->phy.link_info.an_info & ICE_AQ_AN_COMPLETED)
+		an = "True";
+	else
+		an = "False";
+
 	/* Get FEC mode requested based on PHY caps last SW configuration */
 	caps = devm_kzalloc(&vsi->back->pdev->dev, sizeof(*caps), GFP_KERNEL);
 	if (!caps) {
@@ -733,8 +740,8 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	devm_kfree(&vsi->back->pdev->dev, caps);
 
 done:
-	netdev_info(vsi->netdev, "NIC Link is up %sbps, Requested FEC: %s, FEC: %s, Flow Control: %s\n",
-		    speed, fec_req, fec, fc);
+	netdev_info(vsi->netdev, "NIC Link is up %sbps, Requested FEC: %s, FEC: %s, Autoneg: %s, Flow Control: %s\n",
+		    speed, fec_req, fec, an, fc);
 }
 
 /**
-- 
2.20.1

