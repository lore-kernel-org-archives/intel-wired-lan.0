From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 21 Mar 2022 15:47:31 +0100
Subject: [Intel-wired-lan] [PATCH net-next] Revert "ice: Hide bus-info in
 ethtool for PRs in switchdev mode"
Message-ID: <20220321144731.3935-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This reverts commit bfaaba99e680bf82bf2cbf69866c3f37434ff766.

Commit bfaaba99e680 ("ice: Hide bus-info in ethtool for PRs in switchdev
mode") was a workaround for lshw tool displaying incorrect
descriptions for port representors and PF in switchdev mode. Now the issue
has been fixed in the lshw tool itself [1].

[1] https://ezix.org/src/pkg/lshw/commit/9bf4e4c9c1

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 24cda7e1f916..476bd1c83c87 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -190,19 +190,17 @@ __ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
 	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 		 "%x.%02x 0x%x %d.%d.%d", nvm->major, nvm->minor,
 		 nvm->eetrack, orom->major, orom->build, orom->patch);
+
+	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
+		sizeof(drvinfo->bus_info));
 }
 
 static void
 ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
 
 	__ice_get_drvinfo(netdev, drvinfo, np->vsi);
-
-	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
-		sizeof(drvinfo->bus_info));
-
 	drvinfo->n_priv_flags = ICE_PRIV_FLAG_ARRAY_SIZE;
 }
 
-- 
2.35.1

