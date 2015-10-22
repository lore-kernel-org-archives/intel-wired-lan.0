From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 22 Oct 2015 12:10:14 +0300
Subject: [Intel-wired-lan] [patch] igbvf: integer overflow in
	igbvf_change_mtu()
Message-ID: <20151022091013.GC9202@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The "new_mtu" is between 0 and INT_MAX but when we add ETH_HLEN and
ETH_FCS_LEN to it then it could overflow so "max_frame" is negative.  We
cap the upper bound of "max_frame" but we don't check for negative
values.  This leads to a static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 297af80..fa338e0 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2350,7 +2350,7 @@ static struct net_device_stats *igbvf_get_stats(struct net_device *netdev)
 static int igbvf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct igbvf_adapter *adapter = netdev_priv(netdev);
-	int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN;
+	unsigned int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN;
 
 	if (new_mtu < 68 || new_mtu > INT_MAX - ETH_HLEN - ETH_FCS_LEN ||
 	    max_frame > MAX_JUMBO_FRAME_SIZE)
