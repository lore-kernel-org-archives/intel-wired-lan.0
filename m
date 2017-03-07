From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:32:20 +0000
Subject: [Intel-wired-lan] [next PATCH S61 10/10] i40e: Drop FCoE code
 that	always evaluates to false or 0
In-Reply-To: <1487721348-25617-11-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401F47@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S61 10/10] i40e: Drop FCoE code that
> always evaluates to false or 0
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Since FCoE isn't supported by the i40e products there isn't much point in
> carrying around code that will always evaluate to false. This patch goes
> through and strips out the code in several spots so that we don't go around
> carrying variables and/or code that is always going to evaluate to false or 0.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I39d1d779c66c638b75525839db2b6208fdc809d7
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  3 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 17 +++--------------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  1 -
>  3 files changed, 3 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


