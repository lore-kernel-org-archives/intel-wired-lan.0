From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 12 Jan 2018 17:10:14 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: ipsec offload for sparc
In-Reply-To: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
References: <1515805815-2692-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1515805815-2692-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a couple of byteswaps needed to make the ipsec offload
work on big-endian SPARC platforms.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 3d069a2..c5ef09f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -93,7 +93,7 @@ static void ixgbe_ipsec_set_rx_sa(struct ixgbe_hw *hw, u16 idx, __be32 spi,
 	int i;
 
 	/* store the SPI (in bigendian) and IPidx */
-	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, spi);
+	IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, cpu_to_le32(spi));
 	IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
 	IXGBE_WRITE_FLUSH(hw);
 
@@ -121,7 +121,7 @@ static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, __be32 addr[])
 
 	/* store the ip address */
 	for (i = 0; i < 4; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(i), addr[i]);
+		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(i), cpu_to_le32(addr[i]));
 	IXGBE_WRITE_FLUSH(hw);
 
 	ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_ip_tbl);
-- 
2.7.4

