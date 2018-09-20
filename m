From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:08 -0700
Subject: [Intel-wired-lan] [PATCH 5/8] ice: Update comment for
 ice_fltr_mgmt_list_entry
In-Reply-To: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002311.10891-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Previously the comment stated that VSI lists should be used when a
second VSI becomes a subscriber to the "VLAN address". VSI lists
are always used for VLAN membership, so replace "VLAN address" with
"MAC address". Also note that VLAN(s) always use VSI list rules.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 646389ca1238..e12940e70000 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -140,7 +140,8 @@ struct ice_fltr_list_entry {
 /* This defines an entry in the list that maintains MAC or VLAN membership
  * to HW list mapping, since multiple VSIs can subscribe to the same MAC or
  * VLAN. As an optimization the VSI list should be created only when a
- * second VSI becomes a subscriber to the VLAN address.
+ * second VSI becomes a subscriber to the same MAC address. VSI lists are always
+ * used for VLAN membership.
  */
 struct ice_fltr_mgmt_list_entry {
 	/* back pointer to VSI list id to VSI list mapping */
-- 
2.14.3

