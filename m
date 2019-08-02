From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:28 -0700
Subject: [Intel-wired-lan] [PATCH S26 10/15] ice: Deduce TSA value from the
 priority value in the CEE mode
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

In CEE mode, the TSA information can be derived from the reported
priority value.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index d60c942249e8..c5ee8d930611 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -444,9 +444,15 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
 	 *        |pg0|pg1|pg2|pg3|pg4|pg5|pg6|pg7|
 	 *        ---------------------------------
 	 */
-	ice_for_each_traffic_class(i)
+	ice_for_each_traffic_class(i) {
 		etscfg->tcbwtable[i] = buf[offset++];
 
+		if (etscfg->prio_table[i] == ICE_CEE_PGID_STRICT)
+			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
+		else
+			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
+	}
+
 	/* Number of TCs supported (1 octet) */
 	etscfg->maxtcs = buf[offset];
 }
-- 
2.20.1

