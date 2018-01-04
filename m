From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 20:30:53 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 01/13] i40e: Add returning
 AQ critical error to SW
In-Reply-To: <20171227131440.23579-1-alice.michael@intel.com>
References: <20171227131440.23579-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6FC9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:15 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S84-V2 01/13] i40e: Add returning AQ
> critical error to SW
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> The FW has the ability to return a critical error on every AQ command.
> When this critical error occurs then we need to send the correct response to
> the caller.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 13 +++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_common.c   |  2 ++
>  drivers/net/ethernet/intel/i40e/i40e_status.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 13 +++++++++----
> drivers/net/ethernet/intel/i40evf/i40e_common.c |  2 ++
> drivers/net/ethernet/intel/i40evf/i40e_status.h |  1 +
>  6 files changed, 24 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


