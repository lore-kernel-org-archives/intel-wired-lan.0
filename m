From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Fri, 22 Apr 2022 13:42:55 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-next 1/3] ice: remove u16
 arithmetic in ice_gnss
Message-ID: <20220422114257.2238368-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change u16 to u32 where arithmetic occurres.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 57586a2e6dec..8a7d67c12ff7 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -23,8 +23,8 @@ static void ice_gnss_read(struct kthread_work *work)
 	struct ice_hw *hw;
 	__be16 data_len_b;
 	char *buf = NULL;
-	u16 i, data_len;
-	int err = 0;
+	unsigned int i;
+	u32 data_len;
 
 	pf = gnss->back;
 	if (!pf || !gnss->tty || !gnss->tty->port) {
@@ -65,7 +65,7 @@ static void ice_gnss_read(struct kthread_work *work)
 		mdelay(10);
 	}
 
-	data_len = min(data_len, (u16)PAGE_SIZE);
+	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
 	data_len = tty_buffer_request_room(port, data_len);
 	if (!data_len) {
 		err = -ENOMEM;
@@ -74,9 +74,10 @@ static void ice_gnss_read(struct kthread_work *work)
 
 	/* Read received data */
 	for (i = 0; i < data_len; i += bytes_read) {
-		u16 bytes_left = data_len - i;
+		u32 bytes_left = data_len - i;
 
-		bytes_read = min_t(typeof(bytes_left), bytes_left, ICE_MAX_I2C_DATA_SIZE);
+		bytes_read = min_t(typeof(bytes_left), bytes_left,
+				   ICE_MAX_I2C_DATA_SIZE);
 
 		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
 				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
-- 
2.34.1

