From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 11:11:06 -0700
Subject: [Intel-wired-lan] [net-next v3 4/7] dp83640: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-1-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
Message-ID: <20190926181109.4871-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the dp83640 PTP support to explicitly reject any future flags that
get added to the external timestamp request ioctl.

In order to maintain currently functioning code, this patch accepts all
three current flags. This is because the PTP_RISING_EDGE and
PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
have interpreted them slightly differently.

Cc: Stefan S?rensen <stefan.sorensen@spectralink.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/phy/dp83640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 04ad77758920..2781b0e2d947 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -469,6 +469,11 @@ static int ptp_dp83640_enable(struct ptp_clock_info *ptp,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
+		/* Reject requests with unsupported flags */
+		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
+					PTP_RISING_EDGE |
+					PTP_FALLING_EDGE))
+			return -EOPNOTSUPP;
 		index = rq->extts.index;
 		if (index >= N_EXT_TS)
 			return -EINVAL;
-- 
2.23.0.245.gf157bbb9169d

