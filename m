From: Saeed Mahameed <saeedm@mellanox.com>
Date: Fri, 15 Nov 2019 00:03:14 +0000
Subject: [Intel-wired-lan] [PATCH net 06/13] mlx5: reject unsupported
 external timestamp flags
In-Reply-To: <20191114184507.18937-7-richardcochran@gmail.com>
References: <20191114184507.18937-7-richardcochran@gmail.com>
Message-ID: <c90050bd6a63ef3a6f0c7ea999f44ec51c07e917.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-11-14 at 10:45 -0800, Richard Cochran wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix the mlx5 core PTP support to explicitly reject any future flags
> that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts
> all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems
> to
> have interpreted them slightly differently.
> 
> [ RC: I'm not 100% sure what this driver does, but if I'm not wrong
> it
>       follows the dp83640:
> 

The driver will check if the PTP_FALLING_EDGE flag was set then it will
set it in HW, if not then it is going to default to PTP_RISING_EDGE, so
LGTM.

Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>

But same story here, old tools that lazily set 0xffff or 0x0000 and
expected every thing to work.. again not sure if they do exist.

Ariel please have a look at this patch.

>   flags                                                 Meaning
>   ----------------------------------------------------  -------------
> -------------
>   PTP_ENABLE_FEATURE                                    Time stamp
> rising edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE                    Time stamp
> rising edge
>   PTP_ENABLE_FEATURE|PTP_FALLING_EDGE                   Time stamp
> falling edge
>   PTP_ENABLE_FEATURE|PTP_RISING_EDGE|PTP_FALLING_EDGE   Time stamp
> falling edge
> ]
> 
> Cc: Feras Daoud <ferasda@mellanox.com>
> Cc: Eugenia Emantayev <eugenia@mellanox.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index cff6b60de304..9a40f24e3193 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -236,6 +236,12 @@ static int mlx5_extts_configure(struct
> ptp_clock_info *ptp,
>  	if (!MLX5_PPS_CAP(mdev))
>  		return -EOPNOTSUPP;
>  
> +	/* Reject requests with unsupported flags */
> +	if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> +				PTP_RISING_EDGE |
> +				PTP_FALLING_EDGE))
> +		return -EOPNOTSUPP;
> +
>  	if (rq->extts.index >= clock->ptp_info.n_pins)
>  		return -EINVAL;
>  
