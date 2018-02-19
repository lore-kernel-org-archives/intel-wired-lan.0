From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 15:40:30 +0200
Subject: [Intel-wired-lan] [PATCH][V2] i40evf: remove redundant array
 comparisons to 0 checks
In-Reply-To: <20180219102330.22045-1-colin.king@canonical.com>
References: <20180219102330.22045-1-colin.king@canonical.com>
Message-ID: <CAHp75Vd-x-26J_QRS=OEpwSa7Uh7o+B=2U7FFS+u__GW04kvBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 19, 2018 at 12:23 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The checks to see if key->dst.s6_addr and key->src.s6_addr are null
> pointers are redundant because these are constant size arrays and
> so the checks always return true.  Fix this by removing the redundant
> checks.   Also replace filter->f with vf, allowing wide lines to be
> condensed and to rejoin some split wide lines.
>
> Detected by CoverityScan, CID#1465279 ("Array compared to 0")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Changelog?


>         u16 addr_type = 0;
>         u16 n_proto = 0;
>         int i = 0;
> +       struct virtchnl_filter *vf = &filter->f;
>

Perhaps perserve reversed xmas tree order?


> -                       filter->f.flow_type = VIRTCHNL_TCP_V6_FLOW;
> +                       vf->flow_type = VIRTCHNL_TCP_V6_FLOW;

No need to touch.

>                 }
>
>                 if (key->ip_proto != IPPROTO_TCP) {
> @@ -2585,9 +2586,8 @@ static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
>                             is_multicast_ether_addr(key->dst)) {
>                                 /* set the mask if a valid dst_mac address */
>                                 for (i = 0; i < ETH_ALEN; i++)
> -                                       filter->f.mask.tcp_spec.dst_mac[i] |=
> -                                                                       0xff;
> -                               ether_addr_copy(filter->f.data.tcp_spec.dst_mac,
> +                                       vf->mask.tcp_spec.dst_mac[i] |= 0xff;
> +                               ether_addr_copy(vf->data.tcp_spec.dst_mac,
>                                                 key->dst);

Instead, keep two pointers:
 ... *pointer_mask = &vf->mask.tcp_spec;
 ... *pointer_data = &vf->data.tcp_spec;


-- 
With Best Regards,
Andy Shevchenko
