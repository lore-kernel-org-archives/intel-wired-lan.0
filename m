From: Jesse Gross <jesse@nicira.com>
Date: Fri, 28 Aug 2015 16:03:26 -0700
Subject: [Intel-wired-lan] [next PATCH S13 14/15] i40e: fix ip-ip GRE
	encapulation
In-Reply-To: <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-15-git-send-email-catherine.sullivan@intel.com>
Message-ID: <CAEP_g=88Nu8uOM0jvd1MTWpwy2+nWst9YQEeWibVt2Zm5mpT0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Aug 28, 2015 at 2:56 PM, Catherine Sullivan
<catherine.sullivan@intel.com> wrote:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 469e1d5..b686450 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[...]
> +#if IS_ENABLED(CONFIG_VXLAN)
> +       return vxlan_features_check(skb, features);
> +#else
>         return features;
> +#endif

I don't think this is right - when VXLAN is compiled in, it will
restrict offload capabilities to that of VXLAN. But when there is no
VXLAN support, all tunnel types will be allowed. Presumably, there is
some underlying hardware capability here for both situations (and
maybe even for GRE as well).
