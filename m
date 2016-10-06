From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Oct 2016 20:43:14 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 10/15] i40e: avoid looping
 to	check whether we're in vlan mode
In-Reply-To: <1475685046-16900-11-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FB03@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 10/15] i40e: avoid looping to
> check whether we're in vlan mode
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We determine that a vsi is in vlan_mode whenever it has any filters with a
> vlan other than -1 (I40E_VLAN_ALL). The previous method of doing so was to
> perform a loop whenever we needed the check. However, we can notice
> that only place where filters are added (i40e_add_filter) can change the
> condition from false to true, and the only place we can return to false is in
> i40e_vsi_sync_filters_subtask. Thus, we can remove the loop and use a
> boolean directly.
> 
> Doing this avoids looping over filters repeatedly especially while we're
> already inside a loop over all the filters. This should reduce the latency of
> filter operations throughout the driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iafde08df588da2a2ea666997d05e11fad8edc338
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 48
> ++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


