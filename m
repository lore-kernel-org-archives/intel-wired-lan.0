From: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Date: Thu, 09 May 2019 12:34:46 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Work around hardware unit hang by
 disabling TSO
Message-ID: <1623942.pXzBnfQ100@rocinante.m.i2n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When forwarding traffic to a client behind NAT, some e1000e devices
become unstable, hanging and then being reset by the watchdog.

Output from syslog:

kernel: e1000e 0000:00:19.0 eth0: Detected Hardware Unit Hang:
kernel:  TDH                  <5f>
kernel:  TDT                  <8d>
kernel:  next_to_use          <8d>
kernel:  next_to_clean        <5c>
kernel: buffer_info[next_to_clean]:
kernel:  time_stamp           <6bd7b>
kernel:  next_to_watch        <5f>
kernel:  jiffies              <6c180>
kernel:  next_to_watch.status <0>
kernel: MAC Status             <40080083>
kernel: PHY Status             <796d>
kernel: PHY 1000BASE-T Status  <7800>
kernel: PHY Extended Status    <3000>
kernel: PCI Status             <10>
kernel: e1000e 0000:00:19.0 eth0: Reset adapter unexpectedly

This repeats several times and never recovers.

Disabling TCP segmentation offload (TSO) seems to be the only way to
work around this problem on the affected devices.

This issue was first reported in 14.01.2015:
https://marc.info/?l=linux-netdev&m=142124954120315

Signed-off-by: Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 8b11682ebba2..4781a45c1047 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6936,6 +6936,12 @@ static netdev_features_t e1000_fix_features(struct net_device *netdev,
 	if ((hw->mac.type >= e1000_pch2lan) && (netdev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_RXFCS;
 
+	if (adapter->pdev->device == E1000_DEV_ID_PCH2_LV_V) {
+		e_info("Disabling TSO on problematic device to avoid hardware unit hang.\n");
+		features &= ~NETIF_F_TSO;
+		features &= ~NETIF_F_TSO6;
+	}
+
 	/* Since there is no support for separate Rx/Tx vlan accel
 	 * enable/disable make sure Tx flag is always in same state as Rx.
 	 */
-- 
2.20.1




