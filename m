From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Sep 2016 17:25:15 +0000
Subject: [Intel-wired-lan] [next PATCH S47 2/9] i40e: Rewrite Flow
 Director	busy wait loop
In-Reply-To: <1473895479-23035-3-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E75E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S47 2/9] i40e: Rewrite Flow Director
> busy wait loop
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We can reorder the busy wait loop at the start of the Flow Director transmit
> function to reduce the overall code size while still retaining the same
> functionality.  As such I am taking advantage of the opportunity to do so.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I34c403ca001953c6ac9816e65d5305e73d869026
> ---
> Testing Hints:
>         Verify Flow Director still functional for adding/deleting rules.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


