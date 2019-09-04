From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:29:50 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/2] i40e: fix hw_dbg
 usage in i40e_hmc_get_object_va
In-Reply-To: <20190903192021.25789-1-maurosr@linux.vnet.ibm.com>
References: <20190903192021.25789-1-maurosr@linux.vnet.ibm.com>
Message-ID: <e8052da5afc9446ca3562362bf5e00a0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Mauro S. M. Rodrigues [mailto:maurosr at linux.vnet.ibm.com]
> Sent: Tuesday, September 3, 2019 12:20 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org;
> davem at davemloft.net; Bowers, AndrewX <andrewx.bowers@intel.com>;
> Jakub Kicinski <jakub.kicinski@netronome.com>;
> maurosr at linux.vnet.ibm.com
> Subject: [PATCH v2 net-next 1/2] i40e: fix hw_dbg usage in
> i40e_hmc_get_object_va
> 
> The mentioned function references a i40e_hw attribute, as parameter for
> hw_dbg, but it doesn't exist in the function scope.
> Fixes it by changing  parameters from i40e_hmc_info to i40e_hw which can
> retrieve the necessary i40e_hmc_info.
> 
> v2:
>  - Fixed reverse xmas tree code style issue as suggested by Jakub Kicinski
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


