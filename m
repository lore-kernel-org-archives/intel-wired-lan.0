From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 26 Sep 2019 11:11:04 -0700
Subject: [Intel-wired-lan] [net-next v3 2/7] net: reject PTP periodic output
 requests with unsupported flags
In-Reply-To: <20190926181109.4871-1-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
Message-ID: <20190926181109.4871-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 823eb2a3c4c7 ("PTP: add support for one-shot output") introduced
a new flag for the PTP periodic output request ioctl. This flag is not
currently supported by any driver.

Fix all drivers which implement the periodic output request ioctl to
explicitly reject any request with flags they do not understand. This
ensures that the driver does not accidentally misinterpret the
PTP_PEROUT_ONE_SHOT flag, or any new flag introduced in the future.

This is important for forward compatibility: if a new flag is
introduced, the driver should reject requests to enable the flag until
the driver has actually been modified to support the flag in question.

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/broadcom/tg3.c                 | 4 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c            | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++++
 drivers/net/ethernet/microchip/lan743x_ptp.c        | 4 ++++
 drivers/net/ethernet/renesas/ravb_ptp.c             | 4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 4 ++++
 drivers/net/phy/dp83640.c                           | 3 +++
 7 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 77f3511b97de..ca3aa1250dd1 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6280,6 +6280,10 @@ static int tg3_ptp_enable(struct ptp_clock_info *ptp,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
+		/* Reject requests with unsupported flags */
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
+
 		if (rq->perout.index != 0)
 			return -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index fd3071f55bd3..4997963149f6 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -551,6 +551,10 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
 		return 0;
 
 	case PTP_CLK_REQ_PEROUT:
+		/* Reject requests with unsupported flags */
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
+
 		if (on) {
 			pin = ptp_find_pin(igb->ptp_clock, PTP_PF_PEROUT,
 					   rq->perout.index);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 0059b290e095..cff6b60de304 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -290,6 +290,10 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 	if (!MLX5_PPS_CAP(mdev))
 		return -EOPNOTSUPP;
 
+	/* Reject requests with unsupported flags */
+	if (rq->perout.flags)
+		return -EOPNOTSUPP;
+
 	if (rq->perout.index >= clock->ptp_info.n_pins)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 57b26c2acf87..e8fe9a90fe4f 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -429,6 +429,10 @@ static int lan743x_ptp_perout(struct lan743x_adapter *adapter, int on,
 	int pulse_width = 0;
 	int perout_bit = 0;
 
+	/* Reject requests with unsupported flags */
+	if (perout->flags)
+		return -EOPNOTSUPP;
+
 	if (!on) {
 		lan743x_ptp_perout_off(adapter);
 		return 0;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 9a42580693cb..638f1fc2166f 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -211,6 +211,10 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int error = 0;
 
+	/* Reject requests with unsupported flags */
+	if (req->flags)
+		return -EOPNOTSUPP;
+
 	if (req->index)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 173493db038c..352dc4c68625 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -140,6 +140,10 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 	switch (rq->type) {
 	case PTP_CLK_REQ_PEROUT:
+		/* Reject requests with unsupported flags */
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
+
 		cfg = &priv->pps[rq->perout.index];
 
 		cfg->start.tv_sec = rq->perout.start.sec;
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 6580094161a9..04ad77758920 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -491,6 +491,9 @@ static int ptp_dp83640_enable(struct ptp_clock_info *ptp,
 		return 0;
 
 	case PTP_CLK_REQ_PEROUT:
+		/* Reject requests with unsupported flags */
+		if (rq->perout.flags)
+			return -EOPNOTSUPP;
 		if (rq->perout.index >= N_PER_OUT)
 			return -EINVAL;
 		return periodic_output(clock, rq, on, rq->perout.index);
-- 
2.23.0.245.gf157bbb9169d

