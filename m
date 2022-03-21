From: Wan Jiabing <wanjiabing@vivo.com>
Date: Mon, 21 Mar 2022 21:59:47 +0800
Subject: [Intel-wired-lan] [PATCH v2] ice: use min_t() to make code cleaner
 in ice_gnss
Message-ID: <20220321135947.378250-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the following coccicheck warning:
./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Use typeof(bytes_left) instead of u8.
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 35579cf4283f..57586a2e6dec 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -76,8 +76,7 @@ static void ice_gnss_read(struct kthread_work *work)
 	for (i = 0; i < data_len; i += bytes_read) {
 		u16 bytes_left = data_len - i;
 
-		bytes_read = bytes_left < ICE_MAX_I2C_DATA_SIZE ? bytes_left :
-					  ICE_MAX_I2C_DATA_SIZE;
+		bytes_read = min_t(typeof(bytes_left), bytes_left, ICE_MAX_I2C_DATA_SIZE);
 
 		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
 				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
-- 
2.35.1

