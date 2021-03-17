From: Jann Horn <jannh@google.com>
Date: Wed, 17 Mar 2021 18:11:29 +0100
Subject: [Intel-wired-lan] [PATCH][next] ixgbe: Fix out-of-bounds
 warning in ixgbe_host_interface_command()
In-Reply-To: <20210317064148.GA55123@embeddedor>
References: <20210317064148.GA55123@embeddedor>
Message-ID: <CAG48ez2RDqKwx=umOHjo_1mYyNQgzvcP=KOw1HgSo4Prs_VQDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 17, 2021 at 8:43 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> Fix the following out-of-bounds warning by replacing the one-element
> array in an anonymous union with a pointer:
>
>   CC [M]  drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c: In function ?ixgbe_host_interface_command?:
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3729:13: warning: array subscript 1 is above array bounds of ?u32[1]? {aka ?unsigned int[1]?} [-Warray-bounds]
>  3729 |   bp->u32arr[bi] = IXGBE_READ_REG_ARRAY(hw, IXGBE_FLEX_MNG, bi);
>       |   ~~~~~~~~~~^~~~
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:3682:7: note: while referencing ?u32arr?
>  3682 |   u32 u32arr[1];
>       |       ^~~~~~
>
> This helps with the ongoing efforts to globally enable -Warray-bounds.
>
> Notice that, the usual approach to fix these sorts of issues is to
> replace the one-element array with a flexible-array member. However,
> flexible arrays should not be used in unions. That, together with the
> fact that the array notation is not being affected in any ways, is why
> the pointer approach was chosen in this case.
>
> Link: https://github.com/KSPP/linux/issues/109
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 62ddb452f862..bff3dc1af702 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -3679,7 +3679,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
>         u32 hdr_size = sizeof(struct ixgbe_hic_hdr);
>         union {
>                 struct ixgbe_hic_hdr hdr;
> -               u32 u32arr[1];
> +               u32 *u32arr;
>         } *bp = buffer;
>         u16 buf_len, dword_len;
>         s32 status;

This looks bogus. An array is inline, a pointer points elsewhere -
they're not interchangeable.
