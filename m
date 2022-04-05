From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 5 Apr 2022 11:11:18 +0000
Subject: [Intel-wired-lan] [next-queue] Add vsi.tx_restart to i40e
 ethtool stats
In-Reply-To: <20220324200338.121394-1-dev@nalramli.com>
References: <20220324200338.121394-1-dev@nalramli.com>
Message-ID: <BYAPR11MB3367D7184876E790CB12E205FCE49@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nabil S. Alramli
> Sent: Friday, March 25, 2022 1:34 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; kuba at kernel.org; intel-wired-
> lan at lists.osuosl.org
> Cc: jdamato at fastly.com; nalramli at fastly.com; Nabil S. Alramli
> <dev@nalramli.com>
> Subject: [Intel-wired-lan] [next-queue] Add vsi.tx_restart to i40e ethtool
> stats
> 
> Add vsi.tx_restart to the i40e driver ethtool statistics
> 
> Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
