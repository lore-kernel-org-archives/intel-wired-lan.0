From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:16 -0700
Subject: [Intel-wired-lan] [PATCH S88 6/8] i40e: Prevent setting link speed
 on I40E_DEV_ID_25G_B
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180314181918.21582-6-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

Setting link settings on backplane devices shouldn't be allowed.
This patch adds one more device id to the list which we check
that against.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d86d0900dfa9..722eb6b1ffff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -861,6 +861,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 	    hw->device_id == I40E_DEV_ID_KX_C ||
 	    hw->device_id == I40E_DEV_ID_20G_KR2 ||
 	    hw->device_id == I40E_DEV_ID_20G_KR2_A ||
+	    hw->device_id == I40E_DEV_ID_25G_B ||
 	    hw->device_id == I40E_DEV_ID_KX_X722) {
 		netdev_info(netdev, "Changing settings is not supported on backplane.\n");
 		return -EOPNOTSUPP;
-- 
2.14.3

