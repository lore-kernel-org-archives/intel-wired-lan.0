From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 31 Oct 2019 09:58:51 -0700
Subject: [Intel-wired-lan] [next-queue/net-next PATCH] e1000e: Use
 netdev_info instead of pr_info for link messages
In-Reply-To: <cf197ef61703cbaa64ac522cf5d191b4b74f64d6.camel@linux.intel.com>
References: <cf197ef61703cbaa64ac522cf5d191b4b74f64d6.camel@linux.intel.com>
Message-ID: <20191031165537.24154.48242.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Replace the pr_info calls with netdev_info in all cases related to the
netdevice link state.

As a result of this patch the link messages will change as shown below.
Before:
e1000e: ens3 NIC Link is Down
e1000e: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

After:
e1000e 0000:00:03.0 ens3: NIC Link is Down
e1000e 0000:00:03.0 ens3: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

Since Joe hasn't gotten back to me on if he wanted to do the patch or if
he wanted me to do it I just went ahead and did it. This should address the
concerns he had about the message formatting in "e1000e: Use rtnl_lock to
prevent race".

 drivers/net/ethernet/intel/e1000e/netdev.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ef8ca0c134b0..a1aa48168855 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4720,7 +4720,7 @@ int e1000e_close(struct net_device *netdev)
 		e1000_free_irq(adapter);
 
 		/* Link status message must follow this format */
-		pr_info("%s NIC Link is Down\n", netdev->name);
+		netdev_info(netdev, "NIC Link is Down\n");
 	}
 
 	napi_disable(&adapter->napi);
@@ -5070,8 +5070,9 @@ static void e1000_print_link_info(struct e1000_adapter *adapter)
 	u32 ctrl = er32(CTRL);
 
 	/* Link status message must follow this format for user tools */
-	pr_info("%s NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
-		adapter->netdev->name, adapter->link_speed,
+	netdev_info(adapter->netdev,
+		"NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
+		adapter->link_speed,
 		adapter->link_duplex == FULL_DUPLEX ? "Full" : "Half",
 		(ctrl & E1000_CTRL_TFCE) && (ctrl & E1000_CTRL_RFCE) ? "Rx/Tx" :
 		(ctrl & E1000_CTRL_RFCE) ? "Rx" :
@@ -5304,7 +5305,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 			adapter->link_speed = 0;
 			adapter->link_duplex = 0;
 			/* Link status message must follow this format */
-			pr_info("%s NIC Link is Down\n", adapter->netdev->name);
+			netdev_info(netdev, "NIC Link is Down\n");
 			netif_carrier_off(netdev);
 			netif_stop_queue(netdev);
 			if (!test_bit(__E1000_DOWN, &adapter->state))

