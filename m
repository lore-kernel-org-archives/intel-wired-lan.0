From: Shannon Nelson <shannon.nelson@intel.com>
Date: Tue, 16 Feb 2016 09:58:27 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: remove redundant check on
	vsi->active_vlans
In-Reply-To: <1455407836-7188-1-git-send-email-colin.king@canonical.com>
References: <1455407836-7188-1-git-send-email-colin.king@canonical.com>
Message-ID: <CAP-MU4Mjq6oXfvuO=tadWyXgvovVTgTnmJPf4gHbdHd34Y=xAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Feb 13, 2016 at 3:57 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> active_vlans is an unsigned long array, hence a null check on this
> array is superfluous and can be removed.
>
> Detected with static analysis by smatch:
>
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:386
>   i40e_dbg_dump_vsi_seid() warn: this array is probably
>   non-NULL. 'vsi->active_vlans'
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 10744a6..aba28be 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -383,9 +383,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
>                 dev_info(&pf->pdev->dev,
>                          "    netdev: name = %s\n",
>                          vsi->netdev->name);
> -       if (vsi->active_vlans)
> -               dev_info(&pf->pdev->dev,
> -                        "    vlgrp: & = %p\n", vsi->active_vlans);
> +       dev_info(&pf->pdev->dev,
> +                "    vlgrp: & = %p\n", vsi->active_vlans);
>         dev_info(&pf->pdev->dev,
>                  "    netdev_registered = %i, current_netdev_flags = 0x%04x, state = %li flags = 0x%08lx\n",
>                  vsi->netdev_registered,
> --
> 2.7.0
>

Acked-by: Shannon Nelson <shannon.nelson@intel.com>

-- 
==============================================
Mr. Shannon Nelson                        Network Division, Intel Corp.
Shannon.Nelson at intel.com                I don't speak for Intel
                 Parents can't afford to be squeamish
