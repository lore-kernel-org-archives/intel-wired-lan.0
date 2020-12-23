From: Sasha Levin <sashal@kernel.org>
Date: Tue, 22 Dec 2020 21:17:11 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.4 068/130] i40e: report correct
 VF link speed when link state is set to enable
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
Message-ID: <20201223021813.2791612-68-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Stefan Assmann <sassmann@kpanic.de>

[ Upstream commit 6ec12e1e9404acb27a7434220bbe5f75e7bb2859 ]

When the virtual link state was set to "enable" ethtool would report
link speed as 40000Mb/s regardless of the underlying device.
Report the correct link speed.

Example from a XXV710 NIC.
Before:
$ ip link set ens3f0 vf 0 state auto
$  ethtool enp8s2 | grep Speed
        Speed: 25000Mb/s
$ ip link set ens3f0 vf 0 state enable
$ ethtool enp8s2 | grep Speed
        Speed: 40000Mb/s
After:
$ ip link set ens3f0 vf 0 state auto
$  ethtool enp8s2 | grep Speed
        Speed: 25000Mb/s
$ ip link set ens3f0 vf 0 state enable
$ ethtool enp8s2 | grep Speed
        Speed: 25000Mb/s

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 09ff3f335ffa6..7e93ff0a31344 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -63,7 +63,7 @@ static void i40e_vc_notify_vf_link_state(struct i40e_vf *vf)
 	} else if (vf->link_forced) {
 		pfe.event_data.link_event.link_status = vf->link_up;
 		pfe.event_data.link_event.link_speed =
-			(vf->link_up ? VIRTCHNL_LINK_SPEED_40GB : 0);
+			(vf->link_up ? i40e_virtchnl_link_speed(ls->link_speed) : 0);
 	} else {
 		pfe.event_data.link_event.link_status =
 			ls->link_info & I40E_AQ_LINK_UP;
@@ -4375,6 +4375,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_pf *pf = np->vsi->back;
+	struct i40e_link_status *ls = &pf->hw.phy.link_info;
 	struct virtchnl_pf_event pfe;
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
@@ -4412,7 +4413,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_forced = true;
 		vf->link_up = true;
 		pfe.event_data.link_event.link_status = true;
-		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
+		pfe.event_data.link_event.link_speed = i40e_virtchnl_link_speed(ls->link_speed);
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
-- 
2.27.0

