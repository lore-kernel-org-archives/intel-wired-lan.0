From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Sep 2017 22:45:26 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 08/13] i40e: Display
	error	message if module does not meet thermal requirements
In-Reply-To: <20170829093242.41026-8-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA99EF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Sadowski, Filip <filip.sadowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 08/13] i40e: Display error
> message if module does not meet thermal requirements
> 
> From: Filip Sadowski <filip.sadowski@intel.com>
> 
> This patch causes error message to be displayed when NIC detects insertion
> of module that does not meet thermal requirements.
> 
> Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 24 +++++++++++++++++-
> ----
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |  1 +
>  3 files changed, 21 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


