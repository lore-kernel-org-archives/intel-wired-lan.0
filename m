From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:24:33 +0000
Subject: [Intel-wired-lan] [next PATCH S3 6/9] i40e: Further
 implementation of LLDP
In-Reply-To: <20190228175255.54754-6-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367711@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S3 6/9] i40e: Further implementation
> of LLDP
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This code implements driver code changes necessary for LLDP Agent support.
> Modified i40e_aq_start_lldp() and
> i40e_aq_stop_lldp() adding false parameter whether LLDP state should be
> persistent across power cycles.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  5 ++
> .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 20 ++++--
> drivers/net/ethernet/intel/i40e/i40e_common.c | 62
> ++++++++++++++++++-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  4 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |  8 ++-
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  8 files changed, 93 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


