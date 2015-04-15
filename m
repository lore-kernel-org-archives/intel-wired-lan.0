From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 14 Apr 2015 17:02:42 -0700
Subject: [Intel-wired-lan] [PATCH net] i40e: Implement
 ndo_features_check()
In-Reply-To: <1429054549-118911-1-git-send-email-jesse@nicira.com>
References: <1429054549-118911-1-git-send-email-jesse@nicira.com>
Message-ID: <1429056162.2638.25.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-14 at 16:35 -0700, Jesse Gross wrote:
> +/**
> + * i40e_features_check - Validate encapsulated packet conforms to
> limits
> + * @skb: skb buff
> + * @netdev: This physical port's netdev
> + * @features: Offload features that the stack believes apply
> + **/
> +#define I40E_MAX_TUNNEL_HDR_LEN                80
> +static netdev_features_t i40e_features_check(struct sk_buff *skb,
> +                                            struct net_device *dev,
> +                                            netdev_features_t
> features)
> +{

Minor nitpick, although I am not sure what the precedence is.  I
personally do not like putting the define between the function header
comment and the function.  I would prefer the #define above the header
comment.

But if you can find a reason otherwise, I will listen.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150414/9562bdc1/attachment.asc>
