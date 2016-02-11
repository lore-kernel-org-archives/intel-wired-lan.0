From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 11 Feb 2016 21:09:30 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: add helper functions to set
 strings and data for ethtool stats
In-Reply-To: <1455224042-3366-1-git-send-email-jacob.e.keller@intel.com>
References: <1455224042-3366-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB585799D0CF@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, February 11, 2016 12:54 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH] fm10k: add helper functions to set strings and data for
> ethtool stats
> 
> Reduce duplicate code and the amount of indentation by adding
> fm10k_add_stat_strings and fm10k_add_ethtool_stats functions which help
> add fm10k_stat structures to the ethtool stats callbacks. This helps
> increase ease of use for future stat additions, and increases code
> readability. Skip handling of the per-queue stats as these will be
> reworked in a following patch.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> This is a resend of the patch directly on the point where the previous
> version applied in Jeff's queue. Fixes a possible null pointer
> deference.
> 
> Notes:
>     - v2
>     * Restore previous NULL pointer check

Ignore this version please, the change I made is actually not necessary as the original NULL pointer check is invalid.

vf_info is a [0] length array at the end of iov_data which is already checked for NULL, so there is no way to actually get a NULL pointer out of this.

Please do not apply this version and keep the original in the queue.

Regards,
Jake

