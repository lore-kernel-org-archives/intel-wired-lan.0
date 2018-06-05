From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 5 Jun 2018 09:12:30 -0700
Subject: [Intel-wired-lan] [net-queue PATCH 1/2] ixgbe: Avoid loopback
 and fix boolean logic in ipsec_stop_data
In-Reply-To: <20180605151108.3359.9455.stgit@ahduyck-green-test.jf.intel.com>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
 <20180605151108.3359.9455.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <b25bee0f-05a0-f21e-4216-12dcafcd43a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/5/2018 8:11 AM, Alexander Duyck wrote:
> This patch fixes two issues. First we add an early test for the Tx and Rx
> security block ready bits. By doing this we can avoid the need for waits or
> loopback in the event that the security block is already flushed out.
> Secondly we fix the boolean logic that was testing for the Tx OR Rx ready
> bits being set and change it so that we only exit if the Tx AND Rx ready
> bits are both set.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |   13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 38d8cf7..7b23fb0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -158,7 +158,16 @@ static void ixgbe_ipsec_stop_data(struct ixgbe_adapter *adapter)
>   	reg |= IXGBE_SECRXCTRL_RX_DIS;
>   	IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
>   
> -	IXGBE_WRITE_FLUSH(hw);
> +	/* If both Tx and Rx are ready there are no packets
> +	 * that we need to flush so the loopback configuration
> +	 * below is not necessary.
> +	 */
> +	t_rdy = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT) &
> +		IXGBE_SECTXSTAT_SECTX_RDY;
> +	r_rdy = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
> +		IXGBE_SECRXSTAT_SECRX_RDY;
> +	if (t_rdy && r_rdy)
> +		return;
>   
>   	/* If the tx fifo doesn't have link, but still has data,
>   	 * we can't clear the tx sec block.  Set the MAC loopback
> @@ -185,7 +194,7 @@ static void ixgbe_ipsec_stop_data(struct ixgbe_adapter *adapter)
>   			IXGBE_SECTXSTAT_SECTX_RDY;
>   		r_rdy = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
>   			IXGBE_SECRXSTAT_SECRX_RDY;
> -	} while (!t_rdy && !r_rdy && limit--);
> +	} while (!(t_rdy && r_rdy) && limit--);
>   
>   	/* undo loopback if we played with it earlier */
>   	if (!link) {
> 
