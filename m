From: Wan Jiabing <wanjiabing@vivo.com>
Date: Sat, 19 Mar 2022 12:24:14 +0800
Subject: [Intel-wired-lan] [PATCH] ice: use min() to make code cleaner
 in ice_gnss
In-Reply-To: <8822dfa2-bdb8-fceb-e920-94afb50881e8@intel.com>
References: <20220318094629.526321-1-wanjiabing@vivo.com>
 <8822dfa2-bdb8-fceb-e920-94afb50881e8@intel.com>
Message-ID: <YjVa7rJx7TuIo4gm@myhostname>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 18, 2022 at 01:19:26PM -0700, Tony Nguyen wrote:
> 
> On 3/18/2022 2:46 AM, Wan Jiabing wrote:
> > Fix the following coccicheck warning:
> > ./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()
> > 
> > Use min() to make code cleaner.
> > 
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> 
> There are build issues with this patch:
> 
> In file included from ./include/linux/kernel.h:26,
> ???????????????? from drivers/net/ethernet/intel/ice/ice.h:9,
> ???????????????? from drivers/net/ethernet/intel/ice/ice_gnss.c:4:
> drivers/net/ethernet/intel/ice/ice_gnss.c: In function ?ice_gnss_read?:
> ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types
> lacks a cast [-Werror]
> ?? 20 |???????? (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> ????? |?????????????????????????????????? ^~
> ./include/linux/minmax.h:26:18: note: in expansion of macro ?__typecheck?
> ?? 26 |???????????????? (__typecheck(x, y) && __no_side_effects(x, y))
> ????? |????????????????? ^~~~~~~~~~~
> ./include/linux/minmax.h:36:31: note: in expansion of macro ?__safe_cmp?
> ?? 36 |???????? __builtin_choose_expr(__safe_cmp(x, y), \
> ????? |?????????????????????????????? ^~~~~~~~~~
> ./include/linux/minmax.h:45:25: note: in expansion of macro ?__careful_cmp?
> ?? 45 | #define min(x, y)?????? __careful_cmp(x, y, <)
> ????? |???????????????????????? ^~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/ice_gnss.c:79:30: note: in expansion of macro
> ?min?
> ?? 79 |???????????????? bytes_read = min(bytes_left, ICE_MAX_I2C_DATA_SIZE);
> ????? |????????????????????????????? ^~~
> cc1: all warnings being treated as errors
> 

Yes, sorry for the warning.

After check minmax.h, it's better to use min_t and there are no warnings.

Please check the new patch, thanks!

Wan Jiabing
-------------- next part --------------
From 43118a4f14393816054a41e4861106cdb623b3d9 Mon Sep 17 00:00:00 2001
From: Wan Jiabing <wanjiabing@vivo.com>
Date: Sat, 19 Mar 2022 12:01:29 +0800
Subject: [PATCH] ice: use min_t() to make code cleaner in ice_gnss

Fix the following coccicheck warning:
./drivers/net/ethernet/intel/ice/ice_gnss.c:79:26-27: WARNING opportunity for min()

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 35579cf4283f..85ceb7018781 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -76,8 +76,7 @@ static void ice_gnss_read(struct kthread_work *work)
 	for (i = 0; i < data_len; i += bytes_read) {
 		u16 bytes_left = data_len - i;
 
-		bytes_read = bytes_left < ICE_MAX_I2C_DATA_SIZE ? bytes_left :
-					  ICE_MAX_I2C_DATA_SIZE;
+		bytes_read = min_t(u8, bytes_left, ICE_MAX_I2C_DATA_SIZE);
 
 		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
 				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
-- 
2.35.1

