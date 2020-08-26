From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Wed, 26 Aug 2020 15:12:21 +0200
Subject: [Intel-wired-lan] [PATCH] i40e: fix type discrepancy when handling
 PTP related LEDs
Message-ID: <20200826131221.20270-1-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix data types when handling LEDs for PTP external clock synchronization.
Interface of i40e_ptp_set_led_hw() updated.
Detected by sparse tool.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 26f583f..98b5315 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -980,7 +980,7 @@ static void i40e_ptp_set_pin_hw(struct i40e_hw *hw,
  **/
 static void i40e_ptp_set_led_hw(struct i40e_hw *hw,
 				unsigned int led,
-				enum i40e_ptp_gpio_pin_state state)
+				enum i40e_ptp_led_pin_state state)
 {
 	switch (state) {
 	case low:
-- 
2.17.1

