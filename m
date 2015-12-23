From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:49 -0800
Subject: [Intel-wired-lan] [next PATCH S25 09/16] i40e: add 20G speed for tx
	bandwidth calculations
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-10-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When calculating TX bandwidth for VFs, we need to know the link speed to
make sure we don't allocate more bandwidth than is available. Add 20G
link speed to the switch statement so we can support devices that link
at that speed.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I5409f6139d549e5832777db9c22ca0664e0c5f8b
---
Testing-Hints:
Find a device that links at 20G and make sure you can set VF tx bandwidth
on that device.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 8c02fa9..8996627 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2303,6 +2303,9 @@ int i40e_ndo_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 	case I40E_LINK_SPEED_40GB:
 		speed = 40000;
 		break;
+	case I40E_LINK_SPEED_20GB:
+		speed = 20000;
+		break;
 	case I40E_LINK_SPEED_10GB:
 		speed = 10000;
 		break;
-- 
2.1.0

