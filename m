From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:56:09 +0000
Subject: [Intel-wired-lan] [next PATCH S90 2/8] i40e: fix reading LLDP
 configuration
In-Reply-To: <20180420084140.8081-2-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976949@ORSMSX104.amr.corp.intel.com>
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
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S90 2/8] i40e: fix reading LLDP
> configuration
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Previous method for reading LLDP config was based on hard-coded offsets. It
> happened to work, because of structured architecture of the NVM memory.
> In the new approach, known as FLAT, we need to calculate the absolute
> address, instead of using relative values.
> Needed defines for memory location were added.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 91
> ++++++++++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_type.h | 10 ++-
>  3 files changed, 99 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


