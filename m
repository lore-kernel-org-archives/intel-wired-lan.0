From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 20:46:37 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always
 set	the CLEARPBA flag when re-enabling interrupts
In-Reply-To: <20170907120556.45699-4-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0C8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 04/11] i40e/i40evf: always set
> the CLEARPBA flag when re-enabling interrupts
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In the past we changed driver behavior to not clear the PBA when re-
> enabling interrupts. This change was motivated by the flawed belief that
> clearing the PBA would cause a lost interrupt if a receive interrupt occurred
> while interrupts were disabled.
> 
> According to empirical testing this isn't the case. Additionally, the data sheet
> specifically says that we should set the CLEARPBA bit when re-enabling
> interrupts in a polling setup.
> 
> This reverts commit 40d72a509862 ("i40e/i40evf: don't lose interrupts")
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  5 +----
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 +++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 +---
>  5 files changed, 10 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


