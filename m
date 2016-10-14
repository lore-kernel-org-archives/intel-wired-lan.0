From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Oct 2016 22:47:47 +0000
Subject: [Intel-wired-lan] [next PATCH S50 1/6] i40e: Add common
 function	for finding VSI by type
In-Reply-To: <1476224818-16844-2-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
 <1476224818-16844-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA16E9B@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 11, 2016 3:27 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S50 1/6] i40e: Add common function
> for finding VSI by type
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds a common method for finding a VSI by type.  The main
> motivation for doing this is that the Flow Director path actually had two ways
> of handling this, one stopped on first match and one did not.  This patch
> makes it so that all callers of this function will get the same approach for
> finding a VSI.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
> Change-ID: Ibf25de8acd8466582520694424aa87da66965fbd
> ---
> Testing Hints:
>         Verify that Flow Director / NTUPLE filters still function.
>         Verify that having VMDq2 VSIs still block ethtool offline test.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         | 19 +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +-----------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 21 ++++++---------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  5 +----
>  4 files changed, 27 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


