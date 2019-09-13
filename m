From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 13 Sep 2019 17:54:30 +0000
Subject: [Intel-wired-lan] [next PATCH S9 1/7] i40e: Allow updating OROM
 when a NIC is in recovery mode
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <0c6ee8c7ef974cc9812c767fa55bae2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S9 1/7] i40e: Allow updating OROM
> when a NIC is in recovery mode
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Allow OROM update with nvmupdate tool when a NIC is in recovery mode.
> Implemented by not exiting a recovery mode after firmware EMP reset and
> before actual OROM update.
> Previously it was not possible to do the OROM update with nvmupdate tool.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


