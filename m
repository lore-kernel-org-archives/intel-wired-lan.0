From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 11 Apr 2022 05:58:54 +0000
Subject: [Intel-wired-lan] [intel-next v2] i40e: Add tx_stopped stat
In-Reply-To: <1648151218-113215-1-git-send-email-jdamato@fastly.com>
References: <1648151218-113215-1-git-send-email-jdamato@fastly.com>
Message-ID: <BYAPR11MB33670312EB746A347D0B43AFFCEA9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Friday, March 25, 2022 1:17 AM
> To: intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; kuba at kernel.org
> Cc: Joe Damato <jdamato@fastly.com>
> Subject: [intel-next v2] i40e: Add tx_stopped stat
> 
> Track TX queue stop events and export the new stat with ethtool.
> 
> v2:
>   - also export tx_stopped via debugfs
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 5 +++--
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 2 ++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
>  6 files changed, 12 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
