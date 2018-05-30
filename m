From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 May 2018 11:38:31 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: check ipsec ip addr against
 mgmt filters
In-Reply-To: <1527704404-14759-1-git-send-email-shannon.nelson@oracle.com>
References: <1527704404-14759-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <15b46cf1364f8825f68b4698c5576874885b55be.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-05-30 at 11:20 -0700, Shannon Nelson wrote:
> Make sure we don't try to offload the decryption of an incoming
> packet that should get delivered to the management engine.  This
> is a corner case that will likely be very seldom seen, but could
> really confuse someone if they were to hit it.
> 
> Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
> v2 - added the BMC IP check
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 88
> ++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> index 99b170f..e1c9762 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> @@ -445,6 +445,89 @@ static int ixgbe_ipsec_parse_proto_keys(struct
> xfrm_state *xs,
>  }
>  
>  /**
> + * ixgbe_ipsec_check_mgmt_ip - make sure there is no clash with mgmt
> IP filters
> + * @xs: pointer to transformer state struct
> + **/
> +static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
> +{
> +       struct net_device *dev = xs->xso.dev;
> +       struct ixgbe_adapter *adapter = netdev_priv(dev);
> +       struct ixgbe_hw *hw = &adapter->hw;
> +       u32 mfval, manc, reg;
> +       int num_filters = 4;
> +       bool manc_ipv4;
> +       u32 bmcipval;
> +       int i, j;
> +
> +#define MANC_EN_IPV4_FILTER      BIT(24)
> +#define MFVAL_IPV4_FILTER_SHIFT  16
> +#define MFVAL_IPV6_FILTER_SHIFT  24
> +#define MIPAF_ARR(_m, _n)        (IXGBE_MIPAF + ((_m) * 0x10) +
> ((_n) * 4))
> +
> +#define IXGBE_BMCIP(_n)          (0x5050 + ((_n) * 4))
> +#define IXGBE_BMCIPVAL           0x5060
> +#define BMCIP_V4                 0x2
> +#define BMCIP_V6                 0x3
> +#define BMCIP_MASK               0x3

Minor nitpick, maybe indent these define values with tabs versus spaces
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180530/461c5f8a/attachment.asc>
