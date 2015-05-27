From: Shannon Nelson <shannon.nelson@intel.com>
Date: Wed, 27 May 2015 09:31:16 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: remove unneeded tests
In-Reply-To: <1432671974-16704-1-git-send-email-laurent.navet@gmail.com>
References: <1432671974-16704-1-git-send-email-laurent.navet@gmail.com>
Message-ID: <CAP-MU4MNXwJ9SzVbNoBkOM18pfc-E9HBR8OUOviFBxeyJpeTfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 26, 2015 at 1:26 PM, Laurent Navet <laurent.navet@gmail.com> wrote:
> The same code is executed regardless ret_code value, so these tests can
> be removed.
> Fix Coverity CID 1268789 and 1268791
>
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
> index 9b987cc..eae4248 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
> @@ -298,8 +298,6 @@ i40e_status i40e_remove_sd_bp_new(struct i40e_hw *hw,
>                 goto exit;
>         }
>         ret_code = i40e_free_dma_mem(hw, &(sd_entry->u.bp.addr));
> -       if (ret_code)
> -               goto exit;
>  exit:
>         return ret_code;
>  }
> @@ -353,8 +351,6 @@ i40e_status i40e_remove_pd_page_new(struct i40e_hw *hw,
>         }
>         /* free memory here */
>         ret_code = i40e_free_dma_mem(hw, &(sd_entry->u.pd_table.pd_page_addr));
> -       if (ret_code)
> -               goto exit;
>  exit:
>         return ret_code;
>  }
> --

Thanks, Laurent, for noticing this.  You're right, this needs some
attention, but I think by rewriting these two functions a little we
can come up with an even better and simpler solution.  I'll be posting
a different patch soon.

sln
