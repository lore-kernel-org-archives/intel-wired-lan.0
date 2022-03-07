From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 7 Mar 2022 17:17:46 +0300
Subject: [Intel-wired-lan] [PATCH net-next] ice: gnss: fix a NULL vs
 IS_ERR() check
Message-ID: <20220307141746.GD18867@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The tty_alloc_driver() function returns error pointers, it never returns
NULL.

Fixes: 43113ff73453 ("ice: add TTY for GNSS module for E810T device")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 755e1580f368..333c085a228a 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -253,7 +253,7 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 	int err;
 
 	tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
-	if (!tty_driver) {
+	if (IS_ERR(tty_driver)) {
 		dev_err(ice_pf_to_dev(pf), "Failed to allocate memory for GNSS TTY\n");
 		return NULL;
 	}
-- 
2.20.1

