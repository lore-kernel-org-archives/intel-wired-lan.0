From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 11 Feb 2017 00:59:43 +0000
Subject: [Intel-wired-lan] [next PATCH S60-V2 1/1] i40e:
	rename	auto_disable_flags to hw_disabled_flags
In-Reply-To: <1486148262-29051-1-git-send-email-bimmy.pujari@intel.com>
References: <1486148262-29051-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5E564@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, February 03, 2017 10:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S60-V2 1/1] i40e: rename
> auto_disable_flags to hw_disabled_flags
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> A previous commit introduced a field that tracks the features that are
> disabled due to HW resource limitations as opposed to the featured disabled
> by the user. This patch changes the name of the field to make it more
> readable since it might get confusing when looking at code containing both
> the flags field and the auto_disable_features field together.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: Idcc9888659698f6fe3ccff17c8c3f09b5026f708
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  8 ++++++--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 28 +++++++++++++----------
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 20 +++++++++---------
>  4 files changed, 35 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

