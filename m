From: kbuild test robot <lkp@intel.com>
Date: Mon, 17 Jun 2019 23:25:23 +0800
Subject: [Intel-wired-lan] [RFC PATCH] e1000e: e1000_workqueue can be static
In-Reply-To: <20190616145445.9637-1-detlev.casanova@gmail.com>
References: <20190616145445.9637-1-detlev.casanova@gmail.com>
Message-ID: <20190617152523.GA18852@lkp-kbuild08>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: ef431cc0a6a5 ("e1000e: Make watchdog use delayed work")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 netdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 0fc95fb..a1526e7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,7 +39,7 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
-struct workqueue_struct *e1000_workqueue;
+static struct workqueue_struct *e1000_workqueue;
 
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
