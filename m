From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 27 Feb 2020 10:15:01 -0800
Subject: [Intel-wired-lan] [PATCH S40 11/15] ice: fix use of deprecated
 strlcpy()
In-Reply-To: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
Message-ID: <20200227181505.61720-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

checkpatch complains "CHECK:DEPRECATED_API: Deprecated use of 'strlcpy',
prefer 'stracpy or strscpy' instead"; use strscpy.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c67cfae64f2b..fad86dfa4d85 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -173,8 +173,8 @@ ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 	struct ice_hw *hw = &pf->hw;
 	u16 oem_build;
 
-	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
-	strlcpy(drvinfo->version, ice_drv_ver, sizeof(drvinfo->version));
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+	strscpy(drvinfo->version, ice_drv_ver, sizeof(drvinfo->version));
 
 	/* Display NVM version (from which the firmware version can be
 	 * determined) which contains more pertinent information.
@@ -185,7 +185,7 @@ ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 		 "%x.%02x 0x%x %d.%d.%d", nvm_ver_hi, nvm_ver_lo,
 		 hw->nvm.eetrack, oem_ver, oem_build, oem_patch);
 
-	strlcpy(drvinfo->bus_info, pci_name(pf->pdev),
+	strscpy(drvinfo->bus_info, pci_name(pf->pdev),
 		sizeof(drvinfo->bus_info));
 	drvinfo->n_priv_flags = ICE_PRIV_FLAG_ARRAY_SIZE;
 }
-- 
2.20.1

