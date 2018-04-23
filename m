From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:55:23 +0000
Subject: [Intel-wired-lan] [next PATCH S90 1/8] i40e/i40evf: cleanup
 incorrect function doxygen comments
In-Reply-To: <20180420084140.8081-1-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A975939@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S90 1/8] i40e/i40evf: cleanup incorrect
> function doxygen comments
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Recent versions of the Linux kernel now warn about incorrect parameter
> definitions for function comments. Fix up several function comments to
> correctly reflect the current function arguments. This cleans up the warnings
> and helps ensure our documentation is accurate.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c      |  6 ++--
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 37 +++++++++++++----
> -----
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      | 11 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  8 ++---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 24 ++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c         |  1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 22 +++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  4 +--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++--
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 16 +++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 ++-
>  drivers/net/ethernet/intel/i40evf/i40evf_client.c  |  4 +--
> drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  7 ++--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  5 ++-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 11 +------
>  17 files changed, 95 insertions(+), 73 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


