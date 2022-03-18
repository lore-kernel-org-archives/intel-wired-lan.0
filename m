From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri, 18 Mar 2022 17:17:10 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/5] ice: switch: unobscurify
 bitops loop in ice_fill_adv_dummy_packet()
In-Reply-To: <20220318161713.680436-1-alexandr.lobakin@intel.com>
References: <20220318161713.680436-1-alexandr.lobakin@intel.com>
Message-ID: <20220318161713.680436-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A loop performing header modification according to the provided mask
in ice_fill_adv_dummy_packet() is very cryptic (and error-prone).
Replace two identical cast-deferences with a variable. Replace three
struct-member-array-accesses with a variable. Invert the condition,
reduce the indentation by one -> eliminate line wraps.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 075df2474688..0936d39de70c 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5810,13 +5810,15 @@ ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 		 * indicated by the mask to make sure we don't improperly write
 		 * over any significant packet data.
 		 */
-		for (j = 0; j < len / sizeof(u16); j++)
-			if (lkups[i].m_raw[j])
-				((u16 *)(pkt + offset))[j] =
-					(((u16 *)(pkt + offset))[j] &
-					 ~lkups[i].m_raw[j]) |
-					(lkups[i].h_raw[j] &
-					 lkups[i].m_raw[j]);
+		for (j = 0; j < len / sizeof(u16); j++) {
+			u16 *ptr = (u16 *)(pkt + offset);
+			u16 mask = lkups[i].m_raw[j];
+
+			if (!mask)
+				continue;
+
+			ptr[j] = (ptr[j] & ~mask) | (lkups[i].h_raw[j] & mask);
+		}
 	}
 
 	s_rule->pdata.lkup_tx_rx.hdr_len = cpu_to_le16(pkt_len);
-- 
2.35.1

