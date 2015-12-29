From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Tue, 29 Dec 2015 10:32:06 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: restrict synchronization of
	link_up and speed
In-Reply-To: <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
References: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <1451356326-2919-3-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zhu Yanjun <yanjun.zhu@windriver.com>

When the X540 NIC acts as a slave of some virtual NICs, it is very
important to synchronize link_up and link_speed, such as a bonding
driver in 802.3ad mode. When X540 NIC acts as an independent interface,
it is not necessary to synchronize link_up and link_speed. That is,
the time span between link_up and link_speed is acceptable.

Signed-off-by: Zhu Yanjun <yanjun.zhu@windriver.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ace21b9..1bb6056 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6436,8 +6436,15 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	 * time. To X540 NIC, there is a time span between link_up and
 	 * link_speed. As such, only continue if link_up and link_speed are
 	 * ready to X540 NIC.
+	 * The time span between link_up and link_speed is very important
+	 * when the X540 NIC acts as a slave in some virtual NICs, such as
+	 * a bonding driver in 802.3ad mode. When X540 NIC acts as an
+	 * independent interface, it is not necessary to synchronize link_up
+	 * and link_speed.
+	 * In the end, not continue if (X540 NIC && SLAVE && link_speed UNKNOWN)
 	 */
-	if (hw->mac.type == ixgbe_mac_X540)
+	if ((hw->mac.type == ixgbe_mac_X540) &&
+	    (netdev->flags & IFF_SLAVE))
 		if (link_speed == IXGBE_LINK_SPEED_UNKNOWN)
 			return;
 
-- 
1.7.9.5

