From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:18 -0700
Subject: [Intel-wired-lan] [PATCH S45 12/15] ice: support adding 16
 unicast/multicast filter on untrusted VF
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Allow untrusted VF to add 16 unicast/multicast filters. VF uses 1 filter
for the default/perm_addr/LAA MAC, 1 for broadcast, and 16 additional
unicast/multicast filters.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 0adff89a6749..67aa9110fdd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -7,7 +7,10 @@
 
 /* Restrict number of MAC Addr and VLAN that non-trusted VF can programmed */
 #define ICE_MAX_VLAN_PER_VF		8
-#define ICE_MAX_MACADDR_PER_VF		12
+/* MAC filters: 1 is reserved for the VF's default/perm_addr/LAA MAC, 1 for
+ * broadcast, and 16 for additional unicast/multicast filters
+ */
+#define ICE_MAX_MACADDR_PER_VF		18
 
 /* Malicious Driver Detection */
 #define ICE_DFLT_NUM_INVAL_MSGS_ALLOWED		10
-- 
2.20.1

