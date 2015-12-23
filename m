From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Dec 2015 08:22:43 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing the
	kernel
In-Reply-To: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
References: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <CAKgT0Uc7ezCCqYa_n_SpOkm0P9TpEs3m3pOjb9o_Rx8hD_L0pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 22, 2015 at 2:10 PM, Bruce Allan <bruce.w.allan@intel.com> wrote:
> Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a compile
> error rather than crash the kernel.
>
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> index 28837ae..6a9f988 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> @@ -398,7 +398,7 @@ static void fm10k_get_reg_q(struct fm10k_hw *hw, u32 *buff, int i)
>         buff[idx++] = fm10k_read_reg(hw, FM10K_TX_SGLORT(i));
>         buff[idx++] = fm10k_read_reg(hw, FM10K_PFVTCTL(i));
>
> -       BUG_ON(idx != FM10K_REGS_LEN_Q);
> +       BUILD_BUG_ON(idx != FM10K_REGS_LEN_Q);
>  }
>
>  /* If function above adds more registers this define needs to be updated */
> @@ -414,7 +414,7 @@ static void fm10k_get_reg_vsi(struct fm10k_hw *hw, u32 *buff, int i)
>         for (j = 0; j < 32; j++)
>                 buff[idx++] = fm10k_read_reg(hw, FM10K_RETA(i, j));
>
> -       BUG_ON(idx != FM10K_REGS_LEN_VSI);
> +       BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
>  }
>
>  static void fm10k_get_regs(struct net_device *netdev,

I'm not sure that is entirely valid.  It seems like BUILD_BUG_ON
should be given an expression that can be tested at build time, but
the way this code is written I would suspect idx is likely not going
to be a fixed value unless you are compiling with -03 which would
likely unfold most of the loops, so I don't see how BUILD_BUG_ON will
do anything other than be compiled out.

- Alex
