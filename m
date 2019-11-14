From: Saeed Mahameed <saeedm@mellanox.com>
Date: Thu, 14 Nov 2019 23:57:42 +0000
Subject: [Intel-wired-lan] [PATCH net 02/13] net: reject PTP periodic
 output requests with unsupported flags
In-Reply-To: <20191114184507.18937-3-richardcochran@gmail.com>
References: <20191114184507.18937-3-richardcochran@gmail.com>
Message-ID: <7275436b02f9551807f68784d4f4ebaf0adbc35e.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-11-14 at 10:44 -0800, Richard Cochran wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Commit 823eb2a3c4c7 ("PTP: add support for one-shot output")
> introduced
> a new flag for the PTP periodic output request ioctl. This flag is
> not
> currently supported by any driver.
> 
> Fix all drivers which implement the periodic output request ioctl to
> explicitly reject any request with flags they do not understand. This
> ensures that the driver does not accidentally misinterpret the
> PTP_PEROUT_ONE_SHOT flag, or any new flag introduced in the future.
> 
> This is important for forward compatibility: if a new flag is
> introduced, the driver should reject requests to enable the flag
> until
> the driver has actually been modified to support the flag in
> question.

LGTM, just there might be a problem with old tools that didn't clear
the flags upon request and expected PTP periodic .. they will stop to
work with new kernel, am i am not sure if such tools do exist.

But the fact now that we have PTP_PEROUT_ONE_SHOT, we need to trust
both driver and tools to do the right thing.

What are the tools to test PTP_PEROUT_ONE_SHOT ? to support this in
mlx5 it is just a matter of a flipping a bit.

Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>

> 
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c                 | 4 ++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c            | 4 ++++
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++++
>  drivers/net/ethernet/microchip/lan743x_ptp.c        | 4 ++++
>  drivers/net/ethernet/renesas/ravb_ptp.c             | 4 ++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c    | 4 ++++
>  drivers/net/phy/dp83640.c                           | 3 +++
>  7 files changed, 27 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c
> b/drivers/net/ethernet/broadcom/tg3.c
> index 77f3511b97de..ca3aa1250dd1 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -6280,6 +6280,10 @@ static int tg3_ptp_enable(struct
> ptp_clock_info *ptp,
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PEROUT:
> +		/* Reject requests with unsupported flags */
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
> +
>  		if (rq->perout.index != 0)
>  			return -EINVAL;
>  
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c
> b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index fd3071f55bd3..4997963149f6 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -551,6 +551,10 @@ static int igb_ptp_feature_enable_i210(struct
> ptp_clock_info *ptp,
>  		return 0;
>  
>  	case PTP_CLK_REQ_PEROUT:
> +		/* Reject requests with unsupported flags */
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
> +
>  		if (on) {
>  			pin = ptp_find_pin(igb->ptp_clock,
> PTP_PF_PEROUT,
>  					   rq->perout.index);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 0059b290e095..cff6b60de304 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -290,6 +290,10 @@ static int mlx5_perout_configure(struct
> ptp_clock_info *ptp,
>  	if (!MLX5_PPS_CAP(mdev))
>  		return -EOPNOTSUPP;
>  
> +	/* Reject requests with unsupported flags */
> +	if (rq->perout.flags)
> +		return -EOPNOTSUPP;
> +
>  	if (rq->perout.index >= clock->ptp_info.n_pins)
>  		return -EINVAL;
>  
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c
> b/drivers/net/ethernet/microchip/lan743x_ptp.c
> index 57b26c2acf87..e8fe9a90fe4f 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
> @@ -429,6 +429,10 @@ static int lan743x_ptp_perout(struct
> lan743x_adapter *adapter, int on,
>  	int pulse_width = 0;
>  	int perout_bit = 0;
>  
> +	/* Reject requests with unsupported flags */
> +	if (perout->flags)
> +		return -EOPNOTSUPP;
> +
>  	if (!on) {
>  		lan743x_ptp_perout_off(adapter);
>  		return 0;
> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c
> b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 9a42580693cb..638f1fc2166f 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -211,6 +211,10 @@ static int ravb_ptp_perout(struct ptp_clock_info
> *ptp,
>  	unsigned long flags;
>  	int error = 0;
>  
> +	/* Reject requests with unsupported flags */
> +	if (req->flags)
> +		return -EOPNOTSUPP;
> +
>  	if (req->index)
>  		return -EINVAL;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index df638b18b72c..0989e2bb6ee3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -140,6 +140,10 @@ static int stmmac_enable(struct ptp_clock_info
> *ptp,
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PEROUT:
> +		/* Reject requests with unsupported flags */
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
> +
>  		cfg = &priv->pps[rq->perout.index];
>  
>  		cfg->start.tv_sec = rq->perout.start.sec;
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index 6580094161a9..04ad77758920 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -491,6 +491,9 @@ static int ptp_dp83640_enable(struct
> ptp_clock_info *ptp,
>  		return 0;
>  
>  	case PTP_CLK_REQ_PEROUT:
> +		/* Reject requests with unsupported flags */
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
>  		if (rq->perout.index >= N_PER_OUT)
>  			return -EINVAL;
>  		return periodic_output(clock, rq, on, rq-
> >perout.index);
