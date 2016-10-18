From: David Ahern <dsa@cumulusnetworks.com>
Date: Mon, 17 Oct 2016 19:15:50 -0700
Subject: [Intel-wired-lan] [PATCH net-next 08/11] rocker: Flip to the new
	dev walk API
In-Reply-To: <1476756953-30923-1-git-send-email-dsa@cumulusnetworks.com>
References: <1476756953-30923-1-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <1476756953-30923-9-git-send-email-dsa@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Convert rocker to the new dev walk API. This is just a code conversion;
no functional change is intended.

v2
- removed typecast of data

Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5424fb341613..5deb25f26e5f 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2839,20 +2839,37 @@ static bool rocker_port_dev_check_under(const struct net_device *dev,
 	return true;
 }
 
+struct rocker_walk_data {
+	struct rocker *rocker;
+	struct rocker_port *port;
+};
+
+static int rocker_lower_dev_walk(struct net_device *lower_dev, void *_data)
+{
+	struct rocker_walk_data *data = _data;
+	int ret = 0;
+
+	if (rocker_port_dev_check_under(lower_dev, data->rocker)) {
+		data->port = netdev_priv(lower_dev);
+		ret = 1;
+	}
+
+	return ret;
+}
+
 struct rocker_port *rocker_port_dev_lower_find(struct net_device *dev,
 					       struct rocker *rocker)
 {
-	struct net_device *lower_dev;
-	struct list_head *iter;
+	struct rocker_walk_data data;
 
 	if (rocker_port_dev_check_under(dev, rocker))
 		return netdev_priv(dev);
 
-	netdev_for_each_all_lower_dev(dev, lower_dev, iter) {
-		if (rocker_port_dev_check_under(lower_dev, rocker))
-			return netdev_priv(lower_dev);
-	}
-	return NULL;
+	data.rocker = rocker;
+	data.port = NULL;
+	netdev_walk_all_lower_dev(dev, rocker_lower_dev_walk, &data);
+
+	return data.port;
 }
 
 static int rocker_netdevice_event(struct notifier_block *unused,
-- 
2.1.4

