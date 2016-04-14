From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 20:25:59 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: don't use BIT() macro where
 the value isn't a bitmask
In-Reply-To: <1460665047-24907-1-git-send-email-jacob.e.keller@intel.com>
References: <1460665047-24907-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460665559.28210.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-04-14 at 13:17 -0700, Jacob Keller wrote:
> The FM10K_MAX_DATA_PER_TXD is really just using a bitshift as a power
> of
> 2 operation in an efficient manner. We shouldn't represent this as a
> BIT()
> because that obscures the intention of the operation.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h
> b/drivers/net/ethernet/intel/fm10k/fm10k.h
> index fcf106e545c5..e98b86bf0ca1 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> @@ -406,7 +406,7 @@ static inline u16 fm10k_desc_unused(struct
> fm10k_ring *ring)
> ?	?(&(((union fm10k_rx_desc *)((R)->desc))[i]))
> ?
> ?#define FM10K_MAX_TXD_PWR	14
> -#define FM10K_MAX_DATA_PER_TXD	BIT(FM10K_MAX_TXD_PWR)
> +#define FM10K_MAX_DATA_PER_TXD	(1u << FM10K_MAX_TXD_PWR)
> ?
> ?/* Tx Descriptors needed, worst case */
> ?#define TXD_USE_COUNT(S)	DIV_ROUND_UP((S),
> FM10K_MAX_DATA_PER_TXD)

Note: this *will* cause a checkpatch warning, but as per discussion
with Alex, I think this is a false positive. I don't know if there is a
good way to fix it? Perhaps we could introduce some sort of "power of
2" macro that would leave in a single place, but I really don't know if
that makes a lot of sense. I also am not sure how to make checkpatch.pl
avoid the complaints for specific cases such as this.

Thanks,
Jake
