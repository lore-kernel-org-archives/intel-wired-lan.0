From: Jesse Gross <jesse@nicira.com>
Date: Thu, 11 Jun 2015 18:56:51 -0700
Subject: [Intel-wired-lan] [PATCH V2 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <20150612003659.22911.5645.stgit@mdrustad-wks.jf.intel.com>
References: <20150612003527.22911.62812.stgit@mdrustad-wks.jf.intel.com>
 <20150612003659.22911.5645.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <CAEP_g=9-bLgncpqX0nP4+r-mrRzSyza4FXtLeAmeSMYCC-X9Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 11, 2015 at 5:37 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 3bf2f3cfd9f6..64e6bda05da9 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
[...]
> +#define IXGBE_MAX_TUNNEL_HDR_LEN 80
> +static netdev_features_t
> +ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
> +                    netdev_features_t features)
> +{
> +       if (!skb->encapsulation)
> +               return features;
> +
> +       if (skb_inner_mac_header(skb) - skb_transport_header(skb) >
> +           IXGBE_MAX_TUNNEL_HDR_LEN)
> +               return features & ~(NETIF_F_ALL_CSUM | NETIF_F_GSO_MASK);
> +
> +       return features & ~NETIF_F_ALL_TSO;
> +}

Thanks, this looks nice. One suggestion - you shouldn't need to remove
either NETIF_F_GSO_MASK or NETIF_F_ALL_TSO. Since neither of these
were included in the original encapsulation flags we don't need to
remove them at this point.
