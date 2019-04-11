From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 11 Apr 2019 09:11:33 -0700
Subject: [Intel-wired-lan] [PATCH 1/4] net: Add a define for LLDP ethertype
In-Reply-To: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190411161136.1541-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a new define ETH_P_LLDP for Link Layer Discovery Protocol (LLDP)
ethertype.

Suggested-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 include/uapi/linux/if_ether.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 3a45b4ad71a3..89807b9a9164 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -91,6 +91,7 @@
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
 #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
+#define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
 #define ETH_P_MACSEC	0x88E5		/* 802.1ae MACsec */
 #define ETH_P_8021AH	0x88E7          /* 802.1ah Backbone Service Tag */
 #define ETH_P_MVRP	0x88F5          /* 802.1Q MVRP                  */
-- 
2.20.1

