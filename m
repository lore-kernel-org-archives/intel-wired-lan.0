From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 9 Dec 2016 10:06:41 -0800
Subject: [Intel-wired-lan] [PATCH v2 2/3] i40e: Add XDP_TX support
In-Reply-To: <20161209082212.29549-3-bjorn.topel@gmail.com>
References: <20161209082212.29549-1-bjorn.topel@gmail.com>
 <20161209082212.29549-3-bjorn.topel@gmail.com>
Message-ID: <584AF2B1.1090908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-12-09 12:22 AM, Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This patch adds proper XDP_TX support.
> 
> Acked-by: John Fastabend <john.r.fastabend@intel.com>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   5 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 273 ++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 303 +++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   5 +
>  4 files changed, 490 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 05d805f439e6..adc1f3f32729 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -545,6 +545,10 @@ struct i40e_vsi {
>  	struct i40e_ring **rx_rings;
>  	struct i40e_ring **tx_rings;
>  
> +	/* The XDP rings are Tx only, and follows the count of the
> +	 * regular rings, i.e. alloc_queue_pairs/num_queue_pairs
> +	 */
> +	struct i40e_ring **xdp_rings;

hmm not really a complaint about your patch but these _rings are using
something like rcu because of the kfree_rcu being called but I don't
see any rcu_dereference_bh() usage or rcu_assign_pointer() :/


I know you just copied the existing pattern. Maybe an i40e dev can
comment.

Thanks,
John
