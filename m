From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 Jul 2016 09:21:22 -0700
Subject: [Intel-wired-lan] [RFC PATCH 23/30] i40e/ethtool: support
	RX_CLS_LOC_ANY
In-Reply-To: <1468824984-65318-24-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <1468824984-65318-24-git-send-email-kan.liang@intel.com>
Message-ID: <CAKgT0UeLeZOj2Z3Zhi_t+2D8xpvtu4WdQPO1zALC5DJ=zsGXEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jul 17, 2016 at 11:56 PM,  <kan.liang@intel.com> wrote:
> From: Kan Liang <kan.liang@intel.com>
>
> The existing special location RX_CLS_LOC_ANY flag is designed for the
> case which the caller does not know/care about the location. Now, this
> flag is only handled in ethtool user space. If the kernel directly calls
> the ETHTOOL_SRXCLSRLINS interface with RX_CLS_LOC_ANY flag set, it will
> error out.
> This patch implements the RX_CLS_LOC_ANY support for i40e driver. It
> finds the available location from the end of the list.
>
> Signed-off-by: Kan Liang <kan.liang@intel.com>

Instead of reinventing the wheel you may wan to take a look at using
ndo_rx_flow_steer instead.  It was basically meant to be used for
kernel space applications to be able to add flow director rules.

> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 38 ++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 1f3537e..4276ed7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2552,6 +2552,32 @@ static int i40e_del_fdir_entry(struct i40e_vsi *vsi,
>         return ret;
>  }
>
> +static int find_empty_slot(struct i40e_pf *pf)
> +{
> +       struct i40e_fdir_filter *rule;
> +       struct hlist_node *node2;
> +       __u32 data = i40e_get_fd_cnt_all(pf);
> +       unsigned long *slot;
> +       int i;
> +
> +       slot = kzalloc(BITS_TO_LONGS(data) * sizeof(long), GFP_KERNEL);
> +       if (!slot)
> +               return -ENOMEM;
> +
> +       hlist_for_each_entry_safe(rule, node2,
> +                                 &pf->fdir_filter_list, fdir_node) {
> +               set_bit(rule->fd_id, slot);
> +       }
> +
> +       for (i = data - 1; i > 0; i--) {
> +               if (!test_bit(i, slot))
> +                       break;
> +       }
> +       kfree(slot);
> +
> +       return i;
> +}
> +

This doesn't seem like a very efficient way to find free slots.  If
you are wanting to make this efficient you might just want to keep the
bitmap always allocated.  In addition if you rewrite this so that it
keeps a variable that you can do a simple increment and test with you
will probably find that more often then not you will be able to find a
free slot on your first try.

>  /**
>   * i40e_add_fdir_ethtool - Add/Remove Flow Director filters
>   * @vsi: pointer to the targeted VSI
> @@ -2588,9 +2614,15 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
>
>         fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
>
> -       if (fsp->location >= (pf->hw.func_caps.fd_filters_best_effort +
> -                             pf->hw.func_caps.fd_filters_guaranteed)) {
> -               return -EINVAL;
> +       if (fsp->location != RX_CLS_LOC_ANY) {
> +               if (fsp->location >= (pf->hw.func_caps.fd_filters_best_effort +
> +                                     pf->hw.func_caps.fd_filters_guaranteed)) {
> +                       return -EINVAL;
> +               }
> +       } else {
> +               fsp->location = find_empty_slot(pf);
> +               if (fsp->location < 0)
> +                       return -ENOSPC;
>         }
>
>         if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&

The ethtool interface isn't really meant to be used for writing rules
from kernel space.  You would likely be much better off just using
ndo_rx_flow_steer instead.  Then it will even give you information
back on where the rule you created now resides.

- Alex
