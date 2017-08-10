From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Aug 2017 18:24:57 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V6 08/12] i40evf: Enable VF
 to	request an alternate queue allocation
In-Reply-To: <20170807142839.60975-9-alice.michael@intel.com>
References: <20170807142839.60975-1-alice.michael@intel.com>
 <20170807142839.60975-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E9019A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 7, 2017 7:29 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S78-V6 08/12] i40evf: Enable VF to
> request an alternate queue allocation
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Currently the VF gets a default number of allocated queues from HW on init
> and it could choose to enable or disable those allocated queues.
> This makes it such that the VF can request more or less underlying allocated
> queues from the PF.
> 
> First the VF negotiates the number of queues it wants that can be supported
> by the PF and if successful asks for a reset.  During reset the PF will reallocate
> the HW queues for the VF and will then remap the new queues.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 +
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 38 ++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 94
> ++++++++++++++++++++--
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 44 +++++++++-
>  4 files changed, 173 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


