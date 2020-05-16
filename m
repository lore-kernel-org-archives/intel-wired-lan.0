From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:40 -0700
Subject: [Intel-wired-lan] [PATCH S43 11/15] ice: set VF default LAN address
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-11-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Remove is_zero_ether_add() check when setting the VF default LAN address.
This check assumed that the address had been delete and zeroed before
calling ice_vc_add_mac_addr(). Now the default LAN address will be set
to the last unicast MAC address added by the VF.

The default LAN address is reported by the PF via ndo_get_vf_config.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index aec619215b2e..b27206423537 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2836,9 +2836,11 @@ ice_vc_add_mac_addr(struct ice_vf *vf, struct ice_vsi *vsi, u8 *mac_addr)
 		return -EIO;
 	}
 
-	/* only set dflt_lan_addr once */
-	if (is_zero_ether_addr(vf->dflt_lan_addr.addr) &&
-	    is_unicast_ether_addr(mac_addr))
+	/* Set the default LAN address to the latest unicast MAC address added
+	 * by the VF. The default LAN address is reported by the PF via
+	 * ndo_get_vf_config.
+	 */
+	if (is_unicast_ether_addr(mac_addr))
 		ether_addr_copy(vf->dflt_lan_addr.addr, mac_addr);
 
 	vf->num_mac++;
-- 
2.20.1

