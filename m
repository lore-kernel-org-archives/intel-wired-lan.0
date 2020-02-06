From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 Feb 2020 01:20:05 -0800
Subject: [Intel-wired-lan] [PATCH S37 v3 07/15] ice: Modify link message
 logging
In-Reply-To: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
Message-ID: <20200206092013.23388-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch modifies link message logging to include "Full Duplex" and
"Negotiated" for FEC, so as to distinguish it from "Requested" FEC.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cddadd308253..809e7bee8f62 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -755,7 +755,7 @@ void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
 	kfree(caps);
 
 done:
-	netdev_info(vsi->netdev, "NIC Link is up %sbps, Requested FEC: %s, FEC: %s, Autoneg: %s, Flow Control: %s\n",
+	netdev_info(vsi->netdev, "NIC Link is up %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
 		    speed, fec_req, fec, an, fc);
 	ice_print_topo_conflict(vsi);
 }
-- 
2.20.1

