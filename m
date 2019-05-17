From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:28:12 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 09/11] iavf: Refactor
 init state machine
In-Reply-To: <20190514173709.62431-9-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB777@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 14, 2019 10:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Pawlak, Jakub <jakub.pawlak@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 09/11] iavf: Refactor init state
> machine
> 
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Cleanup of init state machine, move state specific code to separate functions
> and rewrite the
> iavf_init_task() function.
> 
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 447 ++++++++++++--------
>  1 file changed, 259 insertions(+), 188 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


