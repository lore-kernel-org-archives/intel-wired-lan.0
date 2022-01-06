From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 6 Jan 2022 03:29:48 +0000
Subject: [Intel-wired-lan] [net v2] i40e: fix unsigned stat widths
In-Reply-To: <1639014993-89752-1-git-send-email-jdamato@fastly.com>
References: <202112090744.QwfPrzIW-lkp@intel.com>
 <1639014993-89752-1-git-send-email-jdamato@fastly.com>
Message-ID: <BL0PR11MB336333C57FDBC07CBC53E915FC4C9@BL0PR11MB3363.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Thursday, December 9, 2021 7:27 AM
> To: netdev at vger.kernel.org
> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org;
> kuba at kernel.org; davem at davemloft.net; Joe Damato <jdamato@fastly.com>
> Subject: [net v2] i40e: fix unsigned stat widths
> 
> Change i40e_update_vsi_stats and struct i40e_vsi to use u64 fields to match
> the width of the stats counters in struct i40e_rx_queue_stats.
> 
> Update debugfs code to use the correct format specifier for u64.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  v1 -> v2: make tx_restart and tx_busy also u64, and fix format specifiers in
>            debugfs code
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         | 8 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
