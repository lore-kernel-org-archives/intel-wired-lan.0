From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 5 Apr 2022 04:49:33 +0000
Subject: [Intel-wired-lan] [next-queue v2] ice: Add mpls+tso support
In-Reply-To: <1647576732-46414-1-git-send-email-jdamato@fastly.com>
References: <1647576732-46414-1-git-send-email-jdamato@fastly.com>
Message-ID: <BYAPR11MB33679027CBE4CEA415B9615CFCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Friday, March 18, 2022 9:42 AM
> To: intel-wired-lan at lists.osuosl.org; kuba at kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>
> Cc: Joe Damato <jdamato@fastly.com>
> Subject: [next-queue v2] ice: Add mpls+tso support
> 
> Attempt to add mpls+tso support.
> 
> I don't have ice hardware available to test myself, but I just implemented this
> feature in i40e and thought it might be useful to implement for ice while this
> is fresh in my brain.
> 
> Hoping some one at intel will be able to test this on my behalf.
> 
> v1 -> v2:
> 	- In ice_tx_csum, only set ICE_TX_FLAGS_IPV6 if ip v6 is detected
> 	  explicitly. All cases other than ipv4 or ipv6 leave first->tx_flags
> 	  unset, which allows for ice_tx_csum to return -1 to indicate that
> 	  csum offloading is not supported.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c |  4 +++-
> drivers/net/ethernet/intel/ice/ice_txrx.c | 29 +++++++++++++++++++++----
> ----
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
