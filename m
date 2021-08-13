From: zhaoxiao <zhaoxiao@uniontech.com>
Date: Fri, 13 Aug 2021 15:45:36 +0800
Subject: [Intel-wired-lan] [PATCH] igb: handle vlan types with checker
 enabled
Message-ID: <20210813074536.15624-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The sparse build (C=2) finds some issues with how the driver
dealt with the (very difficult) hardware that in some generations
uses little-endian, and in others uses big endian, for the VLAN
field. The code as written picks __le16 as a type and for some
hardware revisions we override it to __be16 as done in this
patch.

drivers/net/ethernet/intel/igb/igb_main.c:2676:48: warning: incorrect type in assignment (different base types)
drivers/net/ethernet/intel/igb/igb_main.c:2676:48:    expected restricted __be16 [usertype] vlan_tci
drivers/net/ethernet/intel/igb/igb_main.c:2676:48:    got unsigned short [usertype] vlan_priority:3

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6221dafc76b9..a42eb9b1fa3e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2673,7 +2673,8 @@ static int igb_parse_cls_flower(struct igb_adapter *adapter,
 			}
 
 			input->filter.match_flags |= IGB_FILTER_FLAG_VLAN_TCI;
-			input->filter.vlan_tci = key->vlan_priority;
+			input->filter.vlan_tci =
+				(__force __be16)key->vlan_priority;
 		}
 	}
 
-- 
2.20.1



