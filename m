From: Yang Yingliang <yangyingliang@huawei.com>
Date: Sat, 5 Mar 2022 17:04:30 +0800
Subject: [Intel-wired-lan] [PATCH -next] ice: fix return value check in
 ice_gnss.c
Message-ID: <20220305090430.3078757-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

kthread_create_worker() and tty_alloc_driver() return ERR_PTR()
and never return NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Fixes: 43113ff73453 ("ice: add TTY for GNSS module for E810T device")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 755e1580f368..35579cf4283f 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -125,7 +125,7 @@ static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
 	 * writes.
 	 */
 	kworker = kthread_create_worker(0, "ice-gnss-%s", dev_name(dev));
-	if (!kworker) {
+	if (IS_ERR(kworker)) {
 		kfree(gnss);
 		return NULL;
 	}
@@ -253,7 +253,7 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 	int err;
 
 	tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
-	if (!tty_driver) {
+	if (IS_ERR(tty_driver)) {
 		dev_err(ice_pf_to_dev(pf), "Failed to allocate memory for GNSS TTY\n");
 		return NULL;
 	}
-- 
2.25.1

