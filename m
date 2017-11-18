From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 18 Nov 2017 11:52:19 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Support
 only TCP filters via big buffer
In-Reply-To: <151096270698.41070.15719394215346077510.stgit@anamdev.jf.intel.com>
References: <151096270698.41070.15719394215346077510.stgit@anamdev.jf.intel.com>
Message-ID: <CAKgT0UdZm1cyNvz7fEThYAKPpiWKc-e9ZjcE9+4HZp2EJxLDaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Nov 17, 2017 at 3:51 PM, Amritha Nambiar
<amritha.nambiar@intel.com> wrote:
> Change big buffer cloud filter function to operate in TCP
> only mode. UDP based filters are not supported via big buffer
> cloud filters. Also change few return types to indicate
> unsupported vs invalid configuration.
>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>

This should be directed to the net-queue, not the next-queue. We
should have this functionality fixed before it goes out in the
released kernel. The same goes for the other "fix" patch that was
submitted as well. Otherwise the patch itself looks good, just
directed to the wrong queue.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 565ce12..1fa07c10 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -6038,8 +6038,8 @@ static int i40e_validate_and_set_switch_mode(struct i40e_vsi *vsi)
>         /* Set Bit 7 to be valid */
>         mode = I40E_AQ_SET_SWITCH_BIT7_VALID;
>
> -       /* Set L4type to both TCP and UDP support */
> -       mode |= I40E_AQ_SET_SWITCH_L4_TYPE_BOTH;
> +       /* Set L4type for TCP support */
> +       mode |= I40E_AQ_SET_SWITCH_L4_TYPE_TCP;
>
>         /* Set cloud filter mode */
>         mode |= I40E_AQ_SET_SWITCH_MODE_NON_TUNNEL;
> @@ -7038,18 +7038,18 @@ static int i40e_add_del_cloud_filter_big_buf(struct i40e_vsi *vsi,
>              is_valid_ether_addr(filter->src_mac)) ||
>             (is_multicast_ether_addr(filter->dst_mac) &&
>              is_multicast_ether_addr(filter->src_mac)))
> -               return -EINVAL;
> +               return -EOPNOTSUPP;
>
> -       /* Make sure port is specified, otherwise bail out, for channel
> -        * specific cloud filter needs 'L4 port' to be non-zero
> +       /* Big buffer cloud filter needs 'L4 port' to be non-zero. Also, UDP
> +        * ports are not supported via big buffer now.
>          */
> -       if (!filter->dst_port)
> -               return -EINVAL;
> +       if (!filter->dst_port || filter->ip_proto == IPPROTO_UDP)
> +               return -EOPNOTSUPP;
>
>         /* adding filter using src_port/src_ip is not supported at this stage */
>         if (filter->src_port || filter->src_ipv4 ||
>             !ipv6_addr_any(&filter->ip.v6.src_ip6))
> -               return -EINVAL;
> +               return -EOPNOTSUPP;
>
>         /* copy element needed to add cloud filter from filter */
>         i40e_set_cld_element(filter, &cld_filter.element);
> @@ -7060,7 +7060,7 @@ static int i40e_add_del_cloud_filter_big_buf(struct i40e_vsi *vsi,
>             is_multicast_ether_addr(filter->src_mac)) {
>                 /* MAC + IP : unsupported mode */
>                 if (filter->dst_ipv4)
> -                       return -EINVAL;
> +                       return -EOPNOTSUPP;
>
>                 /* since we validated that L4 port must be valid before
>                  * we get here, start with respective "flags" value
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
