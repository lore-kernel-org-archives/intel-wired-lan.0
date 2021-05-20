From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 20 May 2021 08:34:59 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-net 1/2] ice: add ndo_bpf
 callback for safe mode netdev ops
In-Reply-To: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
References: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
Message-ID: <20210520063500.62037-2-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice driver requires a programmable pipeline firmware package in order to
have a support for advanced features. Otherwise, driver falls back to so
called 'safe mode'. For that mode, ndo_bpf callback is not exposed and
when user tries to load XDP program, the following happens:

$ sudo ./xdp1 enp179s0f1
libbpf: Kernel error message: Underlying driver does not support XDP in native mode
link set xdp fd failed

which is sort of confusing, as there is a native XDP support, but not in
the current mode. Improve the user experience by providing the specific
ndo_bpf callback dedicated for safe mode which will make use of extack
to explicitly let the user know that the DDP package is missing and
that's the reason that the XDP can't be loaded onto interface currently.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Fixes: efc2214b6047 ("ice: Add support for XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1033d7836891..dfd4f07837cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2571,6 +2571,20 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	return (ret || xdp_ring_err) ? -ENOMEM : 0;
 }
 
+/**
+ * ice_xdp_safe_mode - XDP handler for safe mode
+ * @dev: netdevice
+ * @xdp: XDP command
+ */
+static int ice_xdp_safe_mode(struct net_device __always_unused *dev,
+			     struct netdev_bpf *xdp)
+{
+	NL_SET_ERR_MSG_MOD(xdp->extack,
+			   "Please provide working DDP firmware package in order to use XDP\n"
+			   "Refer to Documentation/networking/device_drivers/ethernet/intel/ice.rst");
+	return -EOPNOTSUPP;
+}
+
 /**
  * ice_xdp - implements XDP handler
  * @dev: netdevice
@@ -6953,6 +6967,7 @@ static const struct net_device_ops ice_netdev_safe_mode_ops = {
 	.ndo_change_mtu = ice_change_mtu,
 	.ndo_get_stats64 = ice_get_stats64,
 	.ndo_tx_timeout = ice_tx_timeout,
+	.ndo_bpf = ice_xdp_safe_mode,
 };
 
 static const struct net_device_ops ice_netdev_ops = {
-- 
2.20.1

