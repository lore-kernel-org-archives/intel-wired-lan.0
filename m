From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Jul 2021 15:16:44 -0700
Subject: [Intel-wired-lan] [PATCH net-next 7/7] ice: Fix macro name for IPv4
 fragment flag
In-Reply-To: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
Message-ID: <20210716221644.45946-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Guo <jia.guo@intel.com>

In IPv4 header, fragment flags indicate whether the packet needs
to be fragmented or not. The value 0x20 represents MF (More Fragment); fix
the macro name to match this.

Signed-off-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Jeff Guo <jia.guo@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 59ef68f072c0..cbd8424631e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -952,7 +952,7 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 		ice_pkt_insert_u8(loc, ICE_IPV4_TTL_OFFSET, input->ip.v4.ttl);
 		ice_pkt_insert_mac_addr(loc, input->ext_data.dst_mac);
 		if (frag)
-			loc[20] = ICE_FDIR_IPV4_PKT_FLAG_DF;
+			loc[20] = ICE_FDIR_IPV4_PKT_FLAG_MF;
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
 		ice_pkt_insert_u32(loc, ICE_IPV4_DST_ADDR_OFFSET,
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index d2d40e18ae8a..da4163856f4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -48,7 +48,7 @@
  * requests that the packet not be fragmented. MF indicates that a packet has
  * been fragmented.
  */
-#define ICE_FDIR_IPV4_PKT_FLAG_DF		0x20
+#define ICE_FDIR_IPV4_PKT_FLAG_MF		0x20
 
 enum ice_fltr_prgm_desc_dest {
 	ICE_FLTR_PRGM_DESC_DEST_DROP_PKT,
-- 
2.20.1

