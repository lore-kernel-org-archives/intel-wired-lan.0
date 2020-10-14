From: Shannon Nelson <snelson@pensando.io>
Date: Wed, 14 Oct 2020 11:14:21 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fail to create xfrm offload of
 IPsec tunnel mode SA
In-Reply-To: <20201014141748.GA4910@AntonyAntony.local>
References: <20200828111101.GA16518@AntonyAntony.local>
 <20201014141748.GA4910@AntonyAntony.local>
Message-ID: <9ca1d11f-5dfa-1be1-6ced-b046dddd5d00@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/14/20 7:17 AM, Antony Antony wrote:
> Based on talks and indirect references ixgbe IPsec offlod do not
> support IPsec tunnel mode offload. It can only support IPsec transport
> mode offload. Now explicitly fail when creating non transport mode SA
>   with offload to avoid false performance expectations.
>
> Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and remove SA")
> Signed-off-by: Antony Antony <antony@phenome.org>

Acked-by: Shannon Nelson <snelson@pensando.io>

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 5 +++++
>   drivers/net/ethernet/intel/ixgbevf/ipsec.c     | 5 +++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index eca73526ac86..54d47265a7ac 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -575,6 +575,11 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
>   		return -EINVAL;
>   	}
>   
> +	if (xs->props.mode != XFRM_MODE_TRANSPORT) {
> +		netdev_err(dev, "Unsupported mode for ipsec offload\n");
> +		return -EINVAL;
> +	}
> +
>   	if (ixgbe_ipsec_check_mgmt_ip(xs)) {
>   		netdev_err(dev, "IPsec IP addr clash with mgmt filters\n");
>   		return -EINVAL;
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> index 5170dd9d8705..caaea2c920a6 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
> @@ -272,6 +272,11 @@ static int ixgbevf_ipsec_add_sa(struct xfrm_state *xs)
>   		return -EINVAL;
>   	}
>   
> +	if (xs->props.mode != XFRM_MODE_TRANSPORT) {
> +		netdev_err(dev, "Unsupported mode for ipsec offload\n");
> +		return -EINVAL;
> +	}
> +
>   	if (xs->xso.flags & XFRM_OFFLOAD_INBOUND) {
>   		struct rx_sa rsa;
>   

