From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue,  5 May 2020 01:32:18 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Report speed and duplex as unknown
 when device is runtime suspended
Message-ID: <20200504173218.1724-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igb device gets runtime suspended when there's no link partner. We can't
get correct speed under that state:
$ cat /sys/class/net/enp3s0/speed
1000

In addition to that, an error can also be spotted in dmesg:
[  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost

Since device can only be runtime suspended when there's no link partner,
we can directly report the speed and duplex as unknown.

The more generic approach will be wrap get_link_ksettings() with begin()
and complete() callbacks. However, for this particular issue, begin()
calls igb_runtime_resume() , which tries to rtnl_lock() while the lock
is already hold by upper ethtool layer.

So let's take this approach until the igb_runtime_resume() no longer
needs to hold rtnl_lock.

Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 39d3b76a6f5d..b429bca4aa6a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -143,6 +143,12 @@ static int igb_get_link_ksettings(struct net_device *netdev,
 	u32 speed;
 	u32 supported, advertising;
 
+	if (pm_runtime_suspended(&adapter->pdev->dev)) {
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+		cmd->base.speed = SPEED_UNKNOWN;
+		return 0;
+	}
+
 	status = rd32(E1000_STATUS);
 	if (hw->phy.media_type == e1000_media_type_copper) {
 
-- 
2.17.1

