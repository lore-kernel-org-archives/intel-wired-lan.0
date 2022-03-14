From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Mon, 14 Mar 2022 17:43:14 +0100
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix inconsistent indenting
 in ice_switch
Message-ID: <20220314164314.15218-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

Commit 9a225f81f540("ice: Support GTP-U and GTP-C offload in switchdev")
introduced this issue.

Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
There is no "Fixes" tag because patch that caused the
issue is not present in net yet.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 7f3d97595890..25b8f6f726eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5565,7 +5565,7 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 					*offsets = dummy_ipv6_gtpu_ipv4_udp_packet_offsets;
 				} else {
 					*pkt = dummy_ipv6_gtpu_ipv4_tcp_packet;
-				*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_tcp_packet);
+					*pkt_len = sizeof(dummy_ipv6_gtpu_ipv4_tcp_packet);
 					*offsets = dummy_ipv6_gtpu_ipv4_tcp_packet_offsets;
 				}
 			}
-- 
2.35.1

