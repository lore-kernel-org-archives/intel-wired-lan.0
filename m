From: Raanan Avargil <raanan.avargil@intel.com>
Date: Tue, 22 Dec 2015 15:35:03 +0200
Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: Set HW FIFO minimum pointer
	gap for non-gig speeds
In-Reply-To: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
References: <1450791305-11285-1-git-send-email-raanan.avargil@intel.com>
Message-ID: <1450791305-11285-3-git-send-email-raanan.avargil@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Based on feedback from HW team, the configured value of the internal Phy
HW FIFO pointer gap was incorrect for non-gig speeds.
This patch provides the correct configuration.

Signed-off-by: Raanan Avargil <raanan.avargil@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 786d214..e7ccf5f 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1479,6 +1479,18 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 				hw->phy.ops.release(hw);
 				if (ret_val)
 					return ret_val;
+			} else {
+				ret_val = hw->phy.ops.acquire(hw);
+				if (ret_val)
+					return ret_val;
+
+				ret_val = e1e_wphy_locked(hw,
+							  PHY_REG(776, 20),
+							  0xC023);
+				hw->phy.ops.release(hw);
+				if (ret_val)
+					return ret_val;
+
 			}
 		}
 	}
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

