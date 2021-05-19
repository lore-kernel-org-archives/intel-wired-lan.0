From: Guangbin Huang <huangguangbin2@huawei.com>
Date: Wed, 19 May 2021 14:14:43 +0800
Subject: [Intel-wired-lan] [PATCH net-next 3/5] net: e1000e: remove repeated
 word "the" for ich8lan.c
In-Reply-To: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
References: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
Message-ID: <1621404885-20075-4-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hao Chen <chenhao288@hisilicon.com>

There are double "the" in comment, so remove the redundant one.

Signed-off-by: Hao Chen <chenhao288@hisilicon.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 590ad110d383..cf7b3887da1d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4639,7 +4639,7 @@ static s32 e1000_id_led_init_pchlan(struct e1000_hw *hw)
  *  @hw: pointer to the HW structure
  *
  *  ICH8 use the PCI Express bus, but does not contain a PCI Express Capability
- *  register, so the the bus width is hard coded.
+ *  register, so the bus width is hard coded.
  **/
 static s32 e1000_get_bus_info_ich8lan(struct e1000_hw *hw)
 {
-- 
2.8.1

