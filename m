From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jun 2020 12:00:48 +0200
Subject: [Intel-wired-lan] [PATCH 03/11] net: devres: relax
 devm_register_netdev()
In-Reply-To: <20200622100056.10151-1-brgl@bgdev.pl>
References: <20200622100056.10151-1-brgl@bgdev.pl>
Message-ID: <20200622100056.10151-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This devres helper registers a release callback that only unregisters
the net_device. It works perfectly fine with netdev structs that are
not managed on their own. There's no reason to check this - drop the
warning.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 net/devres.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/net/devres.c b/net/devres.c
index 57a6a88d11f6..1583ccb207c0 100644
--- a/net/devres.c
+++ b/net/devres.c
@@ -46,14 +46,6 @@ static void devm_netdev_release(struct device *dev, void *this)
 	unregister_netdev(res->ndev);
 }
 
-static int netdev_devres_match(struct device *dev, void *this, void *match_data)
-{
-	struct net_device_devres *res = this;
-	struct net_device *ndev = match_data;
-
-	return ndev == res->ndev;
-}
-
 /**
  *	devm_register_netdev - resource managed variant of register_netdev()
  *	@dev: managing device for this netdev - usually the parent device
@@ -61,22 +53,13 @@ static int netdev_devres_match(struct device *dev, void *this, void *match_data)
  *
  *	This is a devres variant of register_netdev() for which the unregister
  *	function will be call automatically when the managing device is
- *	detached. Note: the net_device used must also be resource managed by
- *	the same struct device.
+ *	detached.
  */
 int devm_register_netdev(struct device *dev, struct net_device *ndev)
 {
 	struct net_device_devres *dr;
 	int ret;
 
-	/* struct net_device must itself be managed. For now a managed netdev
-	 * can only be allocated by devm_alloc_etherdev_mqs() so the check is
-	 * straightforward.
-	 */
-	if (WARN_ON(!devres_find(dev, devm_free_netdev,
-				 netdev_devres_match, ndev)))
-		return -EINVAL;
-
 	dr = devres_alloc(devm_netdev_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
 		return -ENOMEM;
-- 
2.26.1

