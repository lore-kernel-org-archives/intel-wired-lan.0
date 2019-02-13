From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:16:08 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 06/12] i40e: Update
 i40e_init_dcb to return correct error
In-Reply-To: <20190206230826.24970-6-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FBC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Cao, Chinh T <chinh.t.cao@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 06/12] i40e: Update
> i40e_init_dcb to return correct error
> 
> From: Chinh T Cao <chinh.t.cao@intel.com>
> 
> Modify the i40e_init_dcb to return the correct error when LLDP or DCBX is
> not in operational state.
> 
> Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c  | 28 ++++++++-------------
> drivers/net/ethernet/intel/i40e/i40e_dcb.h  |  2 +-
> drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
>  3 files changed, 13 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


