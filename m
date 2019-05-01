From: kbuild test robot <lkp@intel.com>
Date: Thu, 2 May 2019 05:06:36 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] net: aquantia:
 aq_ndev_driver_name[] can be static
In-Reply-To: <201905020544.AMb7YA2G%lkp@intel.com>
References: <201905020544.AMb7YA2G%lkp@intel.com>
Message-ID: <20190501210635.GA61401@lkp-kbuild09>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 58608082e66d ("net: aquantia: create global service workqueue")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 aq_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 7f45e99..1ea8b77 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -23,7 +23,7 @@ MODULE_VERSION(AQ_CFG_DRV_VERSION);
 MODULE_AUTHOR(AQ_CFG_DRV_AUTHOR);
 MODULE_DESCRIPTION(AQ_CFG_DRV_DESC);
 
-const char aq_ndev_driver_name[] = AQ_CFG_DRV_NAME;
+static const char aq_ndev_driver_name[] = AQ_CFG_DRV_NAME;
 
 static const struct net_device_ops aq_ndev_ops;
 
