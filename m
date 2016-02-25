From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Thu, 25 Feb 2016 23:43:41 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: use fm10k_stats structures
 for	per-queue statistics
In-Reply-To: <EF50CC0C76A53A44BAD798C58E0A157E2734A9C4@ORSMSX103.amr.corp.intel.com>
References: <1454697789-22420-1-git-send-email-jacob.e.keller@intel.com>
 <1454697789-22420-2-git-send-email-jacob.e.keller@intel.com>
 <EF50CC0C76A53A44BAD798C58E0A157E2734A9C4@ORSMSX103.amr.corp.intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A18490D71028@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Singh, Krishneil K
> Sent: Thursday, February 25, 2016 12:33 PM
> To: Keller, Jacob E; Intel Wired LAN
> Subject: Re: [Intel-wired-lan] [PATCH 2/2] fm10k: use fm10k_stats
> structures for per-queue statistics
> 
> 
> 
> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, February 5, 2016 10:43 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: use fm10k_stats structures
> for per-queue statistics
> 
> This will allow us numerous advantages, including
> 
> (a) rework the per-queue stats to only display active queues, reducing
>     clutter on the output. This is important since we often don't have
>     all possible queues enabled.
> 
> (b) use the new streamlined helper functions, reducing duplicate code
>     and increasing readability of the stats logic
> 
> (c) add the additional per-tx and per-rx statistics when
>     debug-statistics is enabled, which may be helpful for future debug
>     work.
> 
> The primary motivation for this change is (a), though (b) and (c) are useful
> additions which were noticed while developing the change.
> 
> Note that this code currently assumes we have the same number of Tx and
> Rx queues which should be true of our driver pretty much always. Even if
> there are a non equal number of Tx and Rx queues, the only result will be a
> few extra statistics displaying 0s. This is better than the current setup which
> shows every disabled queue with all 0s.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

This patch unwittingly adds an extraneous/unnecessary blank line after the local
variable declarations in fm10k_get_sset_count() - checkpatch should have caught
that.

