From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 25 May 2017 02:13:44 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix incorrect pf->flags
In-Reply-To: <1495242112-14835-1-git-send-email-tushar.n.dave@oracle.com>
References: <1495242112-14835-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <1495703624.49259.39.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-05-19 at 18:01 -0700, Tushar Dave wrote:
> Fix bug introduced by 'commit 47994c119a36e ("i40e: remove
> hw_disabled_flags in favor of using separate flag bits")' that
> mistakenly wipes out pf->flags.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

:-(
Not even close to applying, I even tried to apply by hand but the patch
was not near the same as my branch in my tree.  I will forgive this
second instance of a patch generated on different tree/branch, but I
really must insist that you use my tree & branch if you need/want to
make changes to Intel wired LAN driver changes.

> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d5c9c9e..6b98d34 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8821,9 +8821,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  		    (pf->hw.aq.api_min_ver > 4))) {
>  		/* Supported in FW API version higher than 1.4 */
>  		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
> -		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
> +		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
>  	} else {
> -		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
> +		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
>  	}
>  
>  	pf->eeprom_version = 0xDEAD;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170525/5f66082b/attachment.asc>
