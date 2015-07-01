From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 19:37:33 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 7/8] i40e:
 clean	up error status messages
In-Reply-To: <1433449442-31420-8-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1BFB7@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, June 04, 2015 1:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 7/8] i40e: clean
> up error status messages
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Clean up a little confusion in reporting error status in phy and fcoe
> setup error reports by separating the return status from the AQ error.
> 
> Add two decoder functions to make this easier.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I960bcdeef3978a15fec1cdb5eff781d5cbae42fb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 206 +++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  30 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 392 ++++++++++++--------
> -
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |   1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 206 +++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   2 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      |   1 +
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  10 +-
>  9 files changed, 673 insertions(+), 177 deletions(-)
> 
Tested-by:  Jim Young <james.m.young@intel.com>
