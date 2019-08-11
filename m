From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 11 Aug 2019 13:22:39 -0700
Subject: [Intel-wired-lan] [PATCH] net: ixgbe: fix memory leaks
In-Reply-To: <1565554067-4994-1-git-send-email-wenwen@cs.uga.edu>
References: <1565554067-4994-1-git-send-email-wenwen@cs.uga.edu>
Message-ID: <CAKgT0Ue_cSVDd6Tf9ji5zUCNEseAAzUtDG3BS6TEhR8Xh83xQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Aug 11, 2019 at 1:08 PM Wenwen Wang <wenwen@cs.uga.edu> wrote:
>
> In ixgbe_configure_clsu32(), 'jump', 'input', and 'mask' are allocated
> through kzalloc() respectively in a for loop body. Then,
> ixgbe_clsu32_build_input() is invoked to build the input. If this process
> fails, next iteration of the for loop will be executed. However, the
> allocated 'jump', 'input', and 'mask' are not deallocated on this execution
> path, leading to memory leaks.
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index cbaf712..6b7ea87 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9490,6 +9490,10 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
>                                 jump->mat = nexthdr[i].jump;
>                                 adapter->jump_tables[link_uhtid] = jump;
>                                 break;
> +                       } else {
> +                               kfree(mask);
> +                               kfree(input);
> +                               kfree(jump);
>                         }
>                 }
>                 return 0;

So I think this fix is still missing a good chunk of the exception
handling it should have. Specifically we will end up failing and then
trying to allocate for the next rule. It seems like we should probably
stop trying to program rules and unwind the work we have already done.

Also it would probably make sense to return an error if we are unable
to program one of the rules into the hardware. Otherwise things will
fail and the user will never know why.
