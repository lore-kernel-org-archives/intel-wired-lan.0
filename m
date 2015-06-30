From: Young, James M <james.m.young@intel.com>
Date: Tue, 30 Jun 2015 17:34:28 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 8/8] i40e:
 use	BIT and BIT_ULL macros
In-Reply-To: <1433449442-31420-9-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1BAA7@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 8/8] i40e: use BIT
> and BIT_ULL macros
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Use macros for abstracting (1 << foo) to BIT(foo)
> and (1ULL << foo64) to BIT_ULL(foo64) in order to match
> better with kernel requirements.
> 
> NOTE: the adminq_cmd.h file was not modified on purpose because
> of the dependency upon firmware for that file.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I73ee2e48c880d671948aad19bd53ca6b2ac558fc
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             | 56 ++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h         |  8 +--
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 10 +--
>  drivers/net/ethernet/intel/i40e/i40e_diag.c        | 11 ++--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 54 ++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.c        | 12 ++--
>  drivers/net/ethernet/intel/i40e/i40e_fcoe.h        |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h         |  6 +-
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     | 16 ++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 75 +++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  6 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  7 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 39 ++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 44 ++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_type.h        | 22 +++----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 18 +++---
>  drivers/net/ethernet/intel/i40evf/i40e_hmc.h       |  6 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 37 ++++++-----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 42 ++++++------
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      | 22 +++----
>  drivers/net/ethernet/intel/i40evf/i40evf.h         | 42 ++++++------
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 44 ++++++-------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  8 +--
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  4 +-
>  26 files changed, 294 insertions(+), 305 deletions(-)
> 
Tested-by: Jim Young <james.m.young@intel.com>

