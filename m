From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 10 Feb 2022 16:29:26 -0800
Subject: [Intel-wired-lan] [PATCH net v2] ice: enable parsing IPSEC SPI
 headers for RSS
Message-ID: <20220211002926.584554-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The COMMS package can enable the hardware parser to recognize IPSEC
frames with ESP header and SPI identifier.  If this package is available
and configured for loading in /lib/firmware, then the driver will
succeed in enabling this protocol type for RSS.

This in turn allows the hardware to hash over the SPI and use it to pick
a consistent receive queue for the same secure flow. Without this all
traffic is steered to the same queue for multiple traffic threads from
the same IP address. For that reason this is marked as a fix, as the
driver supports the model, but it wasn't enabled.

If the package is not available, adding this type will fail, but the
failure is ignored on purpose as it has no negative affect.

Fixes: c90ed40cefe1 ("ice: Enable writing hardware filtering tables")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
---
v2: add fixes tag and send to net
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0c187cf04fcf..53256aca27c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1684,6 +1684,12 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 	if (status)
 		dev_dbg(dev, "ice_add_rss_cfg failed for sctp6 flow, vsi = %d, error = %d\n",
 			vsi_num, status);
+
+	status = ice_add_rss_cfg(hw, vsi_handle, ICE_FLOW_HASH_ESP_SPI,
+				 ICE_FLOW_SEG_HDR_ESP);
+	if (status)
+		dev_dbg(dev, "ice_add_rss_cfg failed for esp/spi flow, vsi = %d, error = %d\n",
+			vsi_num, status);
 }
 
 /**
-- 
2.34.1

