From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Fri, 25 Sep 2020 15:24:44 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 8/9] sfc: fix kdoc warning
In-Reply-To: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
References: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
Message-ID: <20200925222445.74531-9-jesse.brandeburg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

kernel-doc script as used by W=1, is confused by the macro
usage inside the header describing the efx_ptp_data struct.

drivers/net/ethernet/sfc/ptp.c:345: warning: Function parameter or member 'MC_CMD_PTP_IN_TRANSMIT_LENMAX' not described in 'efx_ptp_data'

After some discussion on the list, break this patch out to
a separate one, and fix the issue through a creative
macro declaration.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Edward Cree <ecree@solarflare.com>
---
v3: unchanged, but it should be noted that the kernel-doc script
    should be fixed by someone smarter than me, to not complain
    about the original code.
v2: split this patch out and used custom fix to work around
    kernel-doc script.
---
 drivers/net/ethernet/sfc/mcdi.h | 1 +
 drivers/net/ethernet/sfc/ptp.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index ef6d21e4bd0b..69c2924a147c 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -190,6 +190,7 @@ void efx_mcdi_sensor_event(struct efx_nic *efx, efx_qword_t *ev);
  * 32-bit-aligned.  Also, on Siena we must copy to the MC shared
  * memory strictly 32 bits at a time, so add any necessary padding.
  */
+#define MCDI_TX_BUF_LEN(_len) DIV_ROUND_UP((_len), 4)
 #define _MCDI_DECLARE_BUF(_name, _len)					\
 	efx_dword_t _name[DIV_ROUND_UP(_len, 4)]
 #define MCDI_DECLARE_BUF(_name, _len)					\
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 2e8c4569f03b..aae208fe6b6e 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -326,7 +326,7 @@ struct efx_ptp_data {
 	struct work_struct pps_work;
 	struct workqueue_struct *pps_workwq;
 	bool nic_ts_enabled;
-	_MCDI_DECLARE_BUF(txbuf, MC_CMD_PTP_IN_TRANSMIT_LENMAX);
+	efx_dword_t txbuf[MCDI_TX_BUF_LEN(MC_CMD_PTP_IN_TRANSMIT_LENMAX)];
 
 	unsigned int good_syncs;
 	unsigned int fast_syncs;
-- 
2.25.4

