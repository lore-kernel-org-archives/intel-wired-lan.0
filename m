From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Mon, 25 Jan 2016 10:22:52 +1100
Subject: [Intel-wired-lan] [net] igbvf: remove "link is Up" message when
	registering mcast address
Message-ID: <1453677772-27075-1-git-send-email-jmaxwell37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A similar issue was addressed a few years ago in the following thread:

http://www.spinics.net/lists/netdev/msg245877.html

At that time there were concerns that removing this statement may cause other
side effects. However the submitter addressed those concerns. But the dialogue
went cold. We have a new case where a customers application is registering and 
un-registering multicast addresses every few seconds. This is leading to many 
"Link is Up" messages in the logs as a result of the 
"netif_carrier_off(netdev)" statement called by igbvf_msix_other(). Also on
some kernels it is interfering with the bonding driver causing it to failover 
and subsequently affecting connectivity.

The Sourgeforge driver does not make this call and is therefore not affected.
If there were any side effects I would expect that driver to also be affected.
I have tested re-loading the igbvf driver and downing the adapter with the PF
entity on the host where the VM has this patch. When I bring it back up again 
connectivity is restored as expected. Therefore I request that this patch gets 
submitted. 

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 297af80..c2dfc22 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -876,7 +876,6 @@ static irqreturn_t igbvf_msix_other(int irq, void *data)
 
 	adapter->int_counter1++;
 
-	netif_carrier_off(netdev);
 	hw->mac.get_link_status = 1;
 	if (!test_bit(__IGBVF_DOWN, &adapter->state))
 		mod_timer(&adapter->watchdog_timer, jiffies + 1);
-- 
1.8.3.1

