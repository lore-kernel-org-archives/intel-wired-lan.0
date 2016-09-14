From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Sep 2016 14:16:04 +0000
Subject: [Intel-wired-lan] [next PATCH S46 8/8] i40evf:
	support	queue-specific settings for interrupt moderation
In-Reply-To: <1473715124-31296-9-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA04E8F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 8/8] i40evf: support queue-
> specific settings for interrupt moderation
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In commit a75e8005d506f3 ("i40e: queue-specific settings for interrupt
> moderation") the i40e driver gained support for setting interrupt moderation
> values per queue. This patch adds support for this feature to the i40evf
> driver as well. In addition, a few changes are made to the i40e
> implementation to add function header documentation comments, as well.
> 
> This behaves in a similar fashion to the implementation in i40e. Thus,
> requesting the moderation value when no queue is provided will report
> queue 0 value, while setting the value without a queue will set all queues at
> once.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I1f310a57c8e6c84a8524c178d44d1b7a6d3a848e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  72 ++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  21 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  26 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   8 +
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   7 -
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 206
> ++++++++++++++++-----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  10 +-
>  7 files changed, 280 insertions(+), 70 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Feature works as expected


