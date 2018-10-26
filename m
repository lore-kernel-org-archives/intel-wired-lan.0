From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:29 -0700
Subject: [Intel-wired-lan] [next PATCH S98 2/6] i40e: always set
 ks->base.speed in i40e_get_settings_link_up
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <20181026213333.51495-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In i40e_get_settings_link_up, set ks->base.speed to SPEED_UNKNOWN
in the case where we don't know the link speed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 71db006..ec46548 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -906,6 +906,7 @@ static void i40e_get_settings_link_up(struct i40e_hw *hw,
 		ks->base.speed = SPEED_100;
 		break;
 	default:
+		ks->base.speed = SPEED_UNKNOWN;
 		break;
 	}
 	ks->base.duplex = DUPLEX_FULL;
-- 
2.9.5

