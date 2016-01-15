From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:13 -0800
Subject: [Intel-wired-lan] [next PATCH S28 06/15] i40e: Fix PROMISC mode for
	Multi-function per port (MFP) devices
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-7-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

This patch falls back to enabling unicast, multicast and
broadcast promiscuous mode when the driver must disable it's use
of "default port" aka defport mode (which is mornally used to
provide a promiscuous mode), due to internal incompatibility
with Multiple Function per Port (aka MFP).

The situation that requires this patch is when Physical
Function 0 is the device being used, and it can support SR-IOV
when MFP is enabled, via the driver creating a VEB on an MFP
enabled adapter.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Ie90b00d0d58782a5dfcf2c3c9725a2eb90bd63d8
---
Testing Hints:
With our driver defaulting to set_switch_config with Promisc except
when L2 filters match, we do not expect to see any mirroring of VF
traffic in the PF since the DCR doesn't make an exception for MFP
case. If we see mirroring than we need to file a separate issue
with the HW team.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ac71ba2..4f4262e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2122,7 +2122,9 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		cur_promisc = (!!(vsi->current_netdev_flags & IFF_PROMISC) ||
 			       test_bit(__I40E_FILTER_OVERFLOW_PROMISC,
 					&vsi->state));
-		if (vsi->type == I40E_VSI_MAIN && pf->lan_veb != I40E_NO_VEB) {
+		if ((vsi->type == I40E_VSI_MAIN) &&
+		    (pf->lan_veb != I40E_NO_VEB) &&
+		    !(pf->flags & I40E_FLAG_MFP_ENABLED)) {
 			/* set defport ON for Main VSI instead of true promisc
 			 * this way we will get all unicast/multicast and VLAN
 			 * promisc behavior but will not get VF or VMDq traffic
-- 
2.1.0

