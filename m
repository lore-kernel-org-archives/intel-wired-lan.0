From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 18:26:07 +0000
Subject: [Intel-wired-lan] [next PATCH S46 6/8] i40e: Strip out debugfs
 hook	for Flow Director filter programming
In-Reply-To: <1473715124-31296-7-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FD0EA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S46 6/8] i40e: Strip out debugfs hook
> for Flow Director filter programming
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This  interface was only ever meant for debug only. Since it is not supposed
> to be here we are removing it.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Id771a1e5e7d3e2b4b7f56591b61fb48c921e1d04
> ---
> Testing Hints:
>         Verify the "add fd_filter" and "rem fd_filter" functionality
>         and all references to it have been removed.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 -
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 80 --------------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  5 +-
>  3 files changed, 3 insertions(+), 84 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Debugfs commands/references removed


