From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 7 Sep 2020 12:32:41 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 4/4] ixgbe,
 xsk: use XSK_NAPI_WEIGHT as NAPI poll budget
In-Reply-To: <20200907150217.30888-5-bjorn.topel@gmail.com>
References: <20200907150217.30888-1-bjorn.topel@gmail.com>
 <20200907150217.30888-5-bjorn.topel@gmail.com>
Message-ID: <20200907123241.447371e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon,  7 Sep 2020 17:02:17 +0200 Bj?rn T?pel wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Start using XSK_NAPI_WEIGHT as NAPI poll budget for the AF_XDP Rx
> zero-copy path.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 3771857cf887..f32c1ba0d237 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -239,7 +239,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>  	bool failure = false;
>  	struct sk_buff *skb;
>  
> -	while (likely(total_rx_packets < budget)) {
> +	while (likely(total_rx_packets < XSK_NAPI_WEIGHT)) {

I was thinking that we'd multiply 'budget' here, not replace it with a
constant. Looks like ixgbe dutifully passes 'per_ring_budget' into the
clean_rx functions, not a complete NAPI budget.

>  		union ixgbe_adv_rx_desc *rx_desc;
>  		struct ixgbe_rx_buffer *bi;
>  		unsigned int size;

