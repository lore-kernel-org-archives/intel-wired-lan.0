From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 11:11:09 -0700
Subject: [Intel-wired-lan] [net-next v3 7/7] renesas: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-1-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
Message-ID: <20190926181109.4871-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the renesas PTP support to explicitly reject any future flags that
get added to the external timestamp request ioctl.

In order to maintain currently functioning code, this patch accepts all
three current flags. This is because the PTP_RISING_EDGE and
PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
have interpreted them slightly differently.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/renesas/ravb_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 638f1fc2166f..666dbee48097 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -182,6 +182,12 @@ static int ravb_ptp_extts(struct ptp_clock_info *ptp,
 	struct net_device *ndev = priv->ndev;
 	unsigned long flags;
 
+	/* Reject requests with unsupported flags */
+	if (req->flags & ~(PTP_ENABLE_FEATURE |
+			   PTP_RISING_EDGE |
+			   PTP_FALLING_EDGE))
+		return -EOPNOTSUPP;
+
 	if (req->index)
 		return -EINVAL;
 
-- 
2.23.0.245.gf157bbb9169d

