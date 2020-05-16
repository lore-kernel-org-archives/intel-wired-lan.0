From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:41 -0700
Subject: [Intel-wired-lan] [PATCH S43 12/15] ice: fix MAC write command
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The manage MAC write command was implemented in an overly complex way
that actually didn't work, as it wasn't symmetric to the manage MAC
read command, and was feeding bytes out of order to the firmware. Fix
the implementation by just using a simple array to represent the MAC
address when it is being written via firmware command.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 10 ++++------
 drivers/net/ethernet/intel/ice/ice_common.c     |  5 +----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index d0ee14254df1..1d939ff4bf99 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -157,13 +157,11 @@ struct ice_aqc_manage_mac_write {
 #define ICE_AQC_MAN_MAC_WR_MC_MAG_EN		BIT(0)
 #define ICE_AQC_MAN_MAC_WR_WOL_LAA_PFR_KEEP	BIT(1)
 #define ICE_AQC_MAN_MAC_WR_S		6
-#define ICE_AQC_MAN_MAC_WR_M		(3 << ICE_AQC_MAN_MAC_WR_S)
+#define ICE_AQC_MAN_MAC_WR_M		ICE_M(3, ICE_AQC_MAN_MAC_WR_S)
 #define ICE_AQC_MAN_MAC_UPDATE_LAA	0
-#define ICE_AQC_MAN_MAC_UPDATE_LAA_WOL	(BIT(0) << ICE_AQC_MAN_MAC_WR_S)
-	/* High 16 bits of MAC address in big endian order */
-	__be16 sah;
-	/* Low 32 bits of MAC address in big endian order */
-	__be32 sal;
+#define ICE_AQC_MAN_MAC_UPDATE_LAA_WOL	BIT(ICE_AQC_MAN_MAC_WR_S)
+	/* byte stream in network order */
+	u8 mac_addr[ETH_ALEN];
 	__le32 addr_high;
 	__le32 addr_low;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 06beae93176e..bba787a6faff 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2010,10 +2010,7 @@ ice_aq_manage_mac_write(struct ice_hw *hw, const u8 *mac_addr, u8 flags,
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_manage_mac_write);
 
 	cmd->flags = flags;
-
-	/* Prep values for flags, sah, sal */
-	cmd->sah = htons(*((const u16 *)mac_addr));
-	cmd->sal = htonl(*((const u32 *)(mac_addr + 2)));
+	ether_addr_copy(cmd->mac_addr, mac_addr);
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
-- 
2.20.1

