From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 2 Mar 2016 20:28:21 +0000
Subject: [Intel-wired-lan] [PATCH v3] fm10k: cleanup fm10k stats and
 remove debug-statistics
In-Reply-To: <1456950183-29413-1-git-send-email-jacob.e.keller@intel.com>
References: <1456950183-29413-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58579E7521@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Wednesday, March 02, 2016 12:23 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH v3] fm10k: cleanup fm10k stats and remove debug-
> statistics
> 
> This change fixes up subtle issues with the current fm10k ethtool stats.
> Primarily, support of debug-statistics and per-queue length statistics
> is not something the current API can handle. Due to the way that ethtool
> works, the number of statistics needs to be static for the life time of
> a given device. Our use of debug-statistics does not really allow for
> this, so this patch drops its use.
> 
> Finish this cleanup by reworking the per-queue stats to use the new
> helper functions which reduce the duplicate and error prone code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Testing Hints: Check that you see all 128 queues for Tx/Rx, as this is
> the expected behavior since the ethtool stats API cannot have non-static
> counts of statistics. Check that debug-statistics have been removed.
> 
> This is based on comments regarding the API upstream after attempts to
> fix it. The only real way to fix this is to implement a new/better
> stats API.

This applies in-place over the top of the previous version in the queue, which had per-queue statistics counts which weren't static.

Thanks,
Jake
