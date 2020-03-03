From: Sasha Levin <sashal@kernel.org>
Date: Mon,  2 Mar 2020 21:48:48 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 4.19 29/32] ice: Don't tell the OS
 that link is going down
In-Reply-To: <20200303024851.10054-1-sashal@kernel.org>
References: <20200303024851.10054-1-sashal@kernel.org>
Message-ID: <20200303024851.10054-29-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

[ Upstream commit 8a55c08d3bbc9ffc9639f69f742e59ebd99f913b ]

Remove code that tell the OS that link is going down when user
change flow control via ethtool. When link is up it isn't certain
that link goes down after 0x0605 aq command. If link doesn't go
down, OS thinks that link is down, but physical link is up. To
reset this state user have to take interface down and up.

If link goes down after 0x0605 command, FW send information
about that and after that driver tells the OS that the link goes
down. So this code in ethtool is unnecessary.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 4c5c87b158f55..627abef829c9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -772,13 +772,6 @@ ice_set_pauseparam(struct net_device *netdev, struct ethtool_pauseparam *pause)
 	else
 		return -EINVAL;
 
-	/* Tell the OS link is going down, the link will go back up when fw
-	 * says it is ready asynchronously
-	 */
-	ice_print_link_msg(vsi, false);
-	netif_carrier_off(netdev);
-	netif_tx_stop_all_queues(netdev);
-
 	/* Set the FC mode and only restart AN if link is up */
 	status = ice_set_fc(pi, &aq_failures, link_up);
 
-- 
2.20.1

