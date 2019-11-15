From: Saeed Mahameed <saeedm@mellanox.com>
Date: Fri, 15 Nov 2019 00:04:19 +0000
Subject: [Intel-wired-lan] [PATCH net 12/13] mlx5: Reject requests to
 enable time stamping on both edges.
In-Reply-To: <20191114184507.18937-13-richardcochran@gmail.com>
References: <20191114184507.18937-13-richardcochran@gmail.com>
Message-ID: <23131f95a2afeb32e49d4db797855b17ea24444e.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-11-14 at 10:45 -0800, Richard Cochran wrote:
> This driver enables rising edge or falling edge, but not both, and so
> this patch validates that the request contains only one of the two
> edges.
> 
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 819097d9b583..43f97601b500 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -243,6 +243,12 @@ static int mlx5_extts_configure(struct
> ptp_clock_info *ptp,
>  				PTP_STRICT_FLAGS))
>  		return -EOPNOTSUPP;
>  
> +	/* Reject requests to enable time stamping on both edges. */
> +	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
> +	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
> +	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
> +		return -EOPNOTSUPP;
> +
>  	if (rq->extts.index >= clock->ptp_info.n_pins)
>  		return -EINVAL;
>  


Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>

