From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Wed, 27 Oct 2021 06:36:54 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ice: matching on nvgre key id
Message-ID: <20211027043654.6445-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ice driver nvgre header is stored in different structure than vxlan
and geneve. Also the id can be 32 bit. Check tunnel type before adding
encap key id matching to reflect these differences.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
This commit should be squashed with "ice: support for GRE in eswitch"

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 2fff16bb5d7c..4e1dac813339 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -138,10 +138,22 @@ ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
 		u32 tenant_id;
 
 		list[i].type = ice_proto_type_from_tunnel(fltr->tunnel_type);
-		tenant_id = be32_to_cpu(fltr->tenant_id) << 8;
-		list[i].h_u.tnl_hdr.vni = cpu_to_be32(tenant_id);
-		memcpy(&list[i].m_u.tnl_hdr.vni, "\xff\xff\xff\x00", 4);
-		i++;
+		switch (fltr->tunnel_type) {
+		case TNL_VXLAN:
+		case TNL_GENEVE:
+			tenant_id = be32_to_cpu(fltr->tenant_id) << 8;
+			list[i].h_u.tnl_hdr.vni = cpu_to_be32(tenant_id);
+			memcpy(&list[i].m_u.tnl_hdr.vni, "\xff\xff\xff\x00", 4);
+			i++;
+			break;
+		case TNL_GRETAP:
+			list[i].h_u.nvgre_hdr.tni_flow = fltr->tenant_id;
+			memcpy(&list[i].m_u.nvgre_hdr.tni_flow, "\xff\xff\xff\xff", 4);
+			i++;
+			break;
+		default:
+			break;
+		}
 	}
 
 	if (flags & (ICE_TC_FLWR_FIELD_ENC_SRC_IPV4 |
-- 
2.31.1

