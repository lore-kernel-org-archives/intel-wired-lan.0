From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 20 Jan 2016 19:53:17 -0800
Subject: [Intel-wired-lan] [PATCH] net: i40e: shut up uninitialized variable
	warnings
Message-ID: <1453348397-79917-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Arnd Bergmann <arnd@arndb.de>

intel/i40e/i40e_txrx.c: In function 'i40e_xmit_frame_ring':
intel/i40e/i40e_txrx.c:2367:20: error: 'oiph' may be used uninitialized in this function [-Werror=maybe-uninitialized]
intel/i40e/i40e_txrx.c:2317:16: note: 'oiph' was declared here
intel/i40e/i40e_txrx.c:2367:17: error: 'oudph' may be used uninitialized in this function [-Werror=maybe-uninitialized]
intel/i40e/i40e_txrx.c:2316:17: note: 'oudph' was declared here

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 16d6758..cffe519 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2405,8 +2405,8 @@ static void i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	struct iphdr *this_ip_hdr;
 	u32 network_hdr_len;
 	u8 l4_hdr = 0;
-	struct udphdr *oudph;
-	struct iphdr *oiph;
+	struct udphdr *oudph = NULL;
+	struct iphdr *oiph = NULL;
 	u32 l4_tunnel = 0;
 
 	if (skb->encapsulation) {
-- 
2.5.0

