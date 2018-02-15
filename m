From: Ramamurthy, Harshitha <harshitha.ramamurthy@intel.com>
Date: Thu, 15 Feb 2018 17:56:40 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf/i40evf_main: Fix variable
 assignment in i40evf_parse_cls_flower
In-Reply-To: <20180215174435.GA19969@embeddedor.com>
References: <20180215174435.GA19969@embeddedor.com>
Message-ID: <1518717442.29950.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-02-15 at 11:44 -0600, Gustavo A. R. Silva wrote:
> It seems this is a copy-paste error and that the proper variable to
> use
> in this particular case is _src_ instead of _dst_.
> 
> Addresses-Coverity-ID: 1465282 ("Copy-paste error")
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Thanks for the patch!

Acked-by:Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index 4955ce3..58be99e 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -2763,7 +2763,7 @@ static int i40evf_parse_cls_flower(struct
> i40evf_adapter *adapter,
> ?
> ?		if (key->src) {
> ?			filter->f.mask.tcp_spec.src_port |=
> cpu_to_be16(0xffff);
> -			filter->f.data.tcp_spec.src_port = key->dst;
> +			filter->f.data.tcp_spec.src_port = key->src;
> ?		}
> ?	}
> ?	filter->f.field_flags = field_flags;
