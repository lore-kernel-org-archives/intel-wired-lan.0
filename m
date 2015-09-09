From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 22:28:52 +0000
Subject: [Intel-wired-lan] [next PATCH S13 08/15] i40e/i40evf: clean up
 some	code
In-Reply-To: <1440798961-17326-9-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5EC7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S13 08/15] i40e/i40evf: clean up some
> code
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Add missings spaces after declarations, remove another __func__ use,
> remove uncessary braces, remove unneeded breaks, and useless returns,
> and generally fix up some code.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ie715d6b64976c50e1c21531685fe0a2bd38c4244
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c      |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |   9 +-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 124 ++++++++++++-----
> ----
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        |   1 -
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  39 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  13 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c    |   3 +-
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |   8 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   6 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |   1 +
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   4 -
>  17 files changed, 125 insertions(+), 103 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
