From: Guangbin Huang <huangguangbin2@huawei.com>
Date: Wed, 19 May 2021 14:14:45 +0800
Subject: [Intel-wired-lan] [PATCH net-next 5/5] net: e1000e: fix misspell
 word "retreived"
In-Reply-To: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
References: <1621404885-20075-1-git-send-email-huangguangbin2@huawei.com>
Message-ID: <1621404885-20075-6-git-send-email-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hao Chen <chenhao288@hisilicon.com>

There is a misspell word "retreived" in comment, so fix it to "retrieved".

Signed-off-by: Hao Chen <chenhao288@hisilicon.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 1db35b2c7750..0f0efee5fc8e 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -2978,7 +2978,7 @@ static u32 e1000_get_phy_addr_for_hv_page(u32 page)
  *  @data: pointer to the data to be read or written
  *  @read: determines if operation is read or write
  *
- *  Reads the PHY register at offset and stores the retreived information
+ *  Reads the PHY register at offset and stores the retrieved information
  *  in data.  Assumes semaphore already acquired.  Note that the procedure
  *  to access these regs uses the address port and data port to read/write.
  *  These accesses done with PHY address 2 and without using pages.
-- 
2.8.1

