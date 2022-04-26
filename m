From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Tue, 26 Apr 2022 14:35:54 +0200
Subject: [Intel-wired-lan] [PATCH v3 intel-next 1/3] ice: remove u16
 arithmetic in ice_gnss
Message-ID: <20220426123556.3041070-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change u16 to u32 where arithmetic occurres.


Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V2 -> V3: Add previously removed err variable
V1 -> V2: Use more native types

 drivers/net/ethernet/intel/ice/ice_gnss.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 57586a2e6dec..ff52082a3c26 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -17,13 +17,13 @@ static void ice_gnss_read(struct kthread_work *work)
 	struct gnss_serial *gnss = container_of(work, struct gnss_serial,
 						read_work.work);
 	struct ice_aqc_link_topo_addr link_topo;
-	u8 i2c_params, bytes_read;
+	unsigned int i, bytes_read, data_len;
 	struct tty_port *port;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	__be16 data_len_b;
 	char *buf = NULL;
-	u16 i, data_len;
+	u8 i2c_params;
 	int err = 0;
 
 	pf = gnss->back;
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

