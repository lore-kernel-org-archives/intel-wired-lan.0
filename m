From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Thu, 31 Dec 2015 15:11:39 +0800
Subject: [Intel-wired-lan] [PATCH V6 1/1] ixgbe: synchronize link_up and
	link_speed of a slave interface
In-Reply-To: <1451545899-16584-1-git-send-email-zyjzyj2000@gmail.com>
References: <1451540268.3348.108.camel@intel.com>
 <1451545899-16584-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <1451545899-16584-2-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zhu Yanjun <yanjun.zhu@windriver.com>

According to the suggestions from Rustad, Mark D, to all the slave 
interfaces, the link_speed and link_up should be synchronized since
the time span between link_up and link_speed will make some virtual
NICs not work well, such as a bonding driver in 802.3ad mode.

Signed-off-by: Zhu Yanjun <yanjun.zhu@windriver.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index aed8d02..fc461b9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6426,6 +6426,11 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	if (netif_carrier_ok(netdev))
 		return;
 
+	/* For all slave interfaces, wait for the link_speed to be known. */
+	if ((netdev->flags & IFF_SLAVE) &&
+	    (link_speed == IXGBE_LINK_SPEED_UNKNOWN))
+		return;
+
 	adapter->flags2 &= ~IXGBE_FLAG2_SEARCH_FOR_SFP;
 
 	switch (hw->mac.type) {
-- 
1.9.1

