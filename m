From: Eryk Rybak <eryk.roch.rybak@intel.com>
Date: Fri, 18 Dec 2020 16:52:55 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU on
 device is out of the range
Message-ID: <20201218165255.6393-1-eryk.roch.rybak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When attempting to link XDP prog with MTU larger than supported,
user is not informed why XDP linking fails. Adding proper
error message.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com> 
Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 630258e..4fdef00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12933,9 +12933,10 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
  * i40e_xdp_setup - add/remove an XDP program
  * @vsi: VSI to changed
  * @prog: XDP program
+ * @extack: netlink extended ack
  **/
-static int i40e_xdp_setup(struct i40e_vsi *vsi,
-			  struct bpf_prog *prog)
+static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
+			  struct netlink_ext_ack *extack)
 {
 	int frame_size = vsi->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
 	struct i40e_pf *pf = vsi->back;
@@ -12944,8 +12945,10 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
 	int i;
 
 	/* Don't allow frames that span over multiple buffers */
-	if (frame_size > vsi->rx_buf_len)
+	if (frame_size > vsi->rx_buf_len) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP");
 		return -EINVAL;
+	}
 
 	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
 	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
@@ -13254,7 +13257,7 @@ static int i40e_xdp(struct net_device *dev,
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return i40e_xdp_setup(vsi, xdp->prog);
+		return i40e_xdp_setup(vsi, xdp->prog, xdp->extack);
 	case XDP_SETUP_XSK_POOL:
 		return i40e_xsk_pool_setup(vsi, xdp->xsk.pool,
 					   xdp->xsk.queue_id);

base-commit: d2c2bbad93b818020657a82121a147e9ace1230d
-- 
2.20.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

