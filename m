From: Chen Zhou <chenzhou10@huawei.com>
Date: Wed, 8 Jan 2020 21:39:59 +0800
Subject: [Intel-wired-lan] [PATCH next] igc: make non-global functions static
Message-ID: <20200108133959.93035-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix sparse warning:
drivers/net/ethernet/intel/igc/igc_ptp.c:512:6:
	warning: symbol 'igc_ptp_tx_work' was not declared. Should it be static?
drivers/net/ethernet/intel/igc/igc_ptp.c:644:6:
	warning: symbol 'igc_ptp_suspend' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 6935065..389a969 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -509,7 +509,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
  * This work function polls the TSYNCTXCTL valid bit to determine when a
  * timestamp has been taken for the current stored skb.
  */
-void igc_ptp_tx_work(struct work_struct *work)
+static void igc_ptp_tx_work(struct work_struct *work)
 {
 	struct igc_adapter *adapter = container_of(work, struct igc_adapter,
 						   ptp_tx_work);
@@ -641,7 +641,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
  * This function stops the overflow check work and PTP Tx timestamp work, and
  * will prepare the device for OS suspend.
  */
-void igc_ptp_suspend(struct igc_adapter *adapter)
+static void igc_ptp_suspend(struct igc_adapter *adapter)
 {
 	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
 		return;
-- 
2.7.4

