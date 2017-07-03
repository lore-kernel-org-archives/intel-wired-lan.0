From: Sabrina Dubroca <sd@queasysnail.net>
Date: Mon,  3 Jul 2017 13:02:55 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix masking of bits read from
	IXGBE_VXLANCTRL register
Message-ID: <fc6577fcc305742e61ea24c6eb519c212717e5ec.1499078414.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ixgbe_clear_udp_tunnel_port(), we read the IXGBE_VXLANCTRL register
and then try to mask some bits out of the value, using the logical
instead of bitwise and operator.

Fixes: a21d0822ff69 ("ixgbe: add support for geneve Rx offload")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d39cba214320..c3e70ec2da0f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4868,7 +4868,7 @@ static void ixgbe_clear_udp_tunnel_port(struct ixgbe_adapter *adapter, u32 mask)
 				IXGBE_FLAG_GENEVE_OFFLOAD_CAPABLE)))
 		return;
 
-	vxlanctrl = IXGBE_READ_REG(hw, IXGBE_VXLANCTRL) && ~mask;
+	vxlanctrl = IXGBE_READ_REG(hw, IXGBE_VXLANCTRL) & ~mask;
 	IXGBE_WRITE_REG(hw, IXGBE_VXLANCTRL, vxlanctrl);
 
 	if (mask & IXGBE_VXLANCTRL_VXLAN_UDPPORT_MASK)
-- 
2.13.2

