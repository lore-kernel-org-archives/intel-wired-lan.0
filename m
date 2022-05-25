From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 25 May 2022 08:55:33 +0000
Subject: [Intel-wired-lan] [PATCH net v4] i40e: Fix call trace in
 setup_tx_descriptors
In-Reply-To: <20220519140145.1917314-1-aleksandr.loktionov@intel.com>
References: <20220519140145.1917314-1-aleksandr.loktionov@intel.com>
Message-ID: <BYAPR11MB336712ED7B18D64CCCD7F10CFCD69@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Thursday, May 19, 2022 7:32 PM
> To: intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Jaron, MichalX
> <michalx.jaron@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v4] i40e: Fix call trace in
> setup_tx_descriptors
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> After PF reset and ethtool -t there was call trace in dmesg sometimes leading
> to panic. When there was some time, around 5 seconds, between reset and
> test there were no errors.
> 
> Problem was that pf reset calls i40e_vsi_close in prep_for_reset and ethtool
> -t calls i40e_vsi_close in diag_test. If there was not enough time between
> those commands the second i40e_vsi_close starts before previous
> i40e_vsi_close was done which leads to crash.
> 
> Add check to diag_test if pf is in reset and don't start offline tests if it is true.
> Add netif_info("testing failed") into unhappy path of i40e_diag_test()
> 
> Fixes: e17bc411aea8 ("i40e: Disable offline diagnostics if VFs are enabled")
> Fixes: 510efb2682b3 ("i40e: Fix ethtool offline diagnostic with netqueues")
> Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
