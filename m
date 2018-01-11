From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 11 Jan 2018 09:10:51 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: add support for reporting 5G link
 speed
Message-ID: <1515679851-5573-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since 5G link speed is supported by some devices, add reporting of 5G link
speed.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 722cc31..addb625 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7259,6 +7259,9 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	case IXGBE_LINK_SPEED_10GB_FULL:
 		speed_str = "10 Gbps";
 		break;
+	case IXGBE_LINK_SPEED_5GB_FULL:
+		speed_str = "5 Gbps";
+		break;
 	case IXGBE_LINK_SPEED_2_5GB_FULL:
 		speed_str = "2.5 Gbps";
 		break;
-- 
2.7.5

