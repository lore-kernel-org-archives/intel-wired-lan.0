From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 16:31:35 +0000
Subject: [Intel-wired-lan] [next PATCH S61 09/10] i40e: Drop FCoE code
 from	core driver files
In-Reply-To: <1487721348-25617-10-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401F37@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S61 09/10] i40e: Drop FCoE code from
> core driver files
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Looking over the code for FCoE it looks like the Rx path has been broken at
> least since the last major Rx refactor almost a year ago.  It seems like FCoE
> isn't supported for any of the Fortville/Fortpark hardware so there isn't much
> point in carrying the code around, especially if it is broken and untested.
> 
> This patch cleans the FCoE code out of the CORE files and permanently sets
> the build flags so that the FCoE bits are stripped out of the shared code.
> 
> It was generated using 2 passes.  First with unifdef, and then manually going
> through and eliminating any extra #ifdef cruft such as an extra
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I892de8fa551cb129ce2361e738ff82ce55fa229e
> ---
> Testing Hints:
>         Driver should function the same as before.  The only real change
>         is that we stripped out code that was either ifdef'ed out or
>         code that was unused since FCoE would never be enabled.
> 
>  drivers/net/ethernet/intel/Kconfig               |  11 -
>  drivers/net/ethernet/intel/i40e/Makefile         |   1 -
>  drivers/net/ethernet/intel/i40e/i40e.h           |  61 +-----
>  drivers/net/ethernet/intel/i40e/i40e_common.c    |  27 ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c   |  19 --
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |  35 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c      | 261 +----------------------
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h     |   3 -
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |   3 -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  26 ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h      |  17 --
>  drivers/net/ethernet/intel/i40e/i40e_type.h      | 138 ------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h    |  12 --
>  13 files changed, 2 insertions(+), 612 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


