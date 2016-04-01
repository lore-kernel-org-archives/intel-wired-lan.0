From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 1 Apr 2016 18:17:34 +0000
Subject: [Intel-wired-lan] [PATCH v7] fm10k: add helper functions for
	ethtool stats
In-Reply-To: <1459534509-4972-1-git-send-email-jacob.e.keller@intel.com>
References: <1459534509-4972-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1459534654.2431.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-01 at 11:15 -0700, Jacob Keller wrote:
> This is a complete replacement for 74bf40286439 ("fm10k: add helper
> functions to set strings and data for ethtool stats", 2016-03-25) on
> Jeff's queue, and this the previous v6 patch should be dropped and
> replaced with this one. 91daf9c6d966 ("fm10k: remove debug-statistics
> support", 2016-03-25) likely depends on this patch.
> 
> This version fixes an issue with per-queue statistics due to a
> copy-paste error in the queue stats structure.
> 
> inter-diff between v6 and v7:
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> index e36ca3f43ae4..f331966ac9df 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> @@ -129,7 +129,7 @@ static const struct fm10k_stats
> fm10k_gstrings_mbx_stats[] = {
> ?
> ?static const struct fm10k_stats fm10k_gstrings_queue_stats[] = {
> ?	FM10K_QUEUE_STAT("packets", stats.packets),
> -	FM10K_QUEUE_STAT("bytes", stats.packets),
> +	FM10K_QUEUE_STAT("bytes", stats.bytes),
> ?};
> ?
> ?#define FM10K_GLOBAL_STATS_LEN
> ARRAY_SIZE(fm10k_gstrings_global_stats)
> 
> Jacob Keller (1):
> ? fm10k: add helper functions to set strings and data for ethtool
> stats
> 
> ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 219 ++++++++++++-
> ----------
> ?1 file changed, 115 insertions(+), 104 deletions(-)
> 

The wiki for upstream patches says you sent this already. This email
should have been marked 0/1 not sure why it wasn't.

I am not 100% sure if this was sent, but if so, we need to quickly
replace it with this version, since it fixes a bug. Otherwise I can
send a separate fix stand alone if Dave has already merged it.

Thanks,
Jake
