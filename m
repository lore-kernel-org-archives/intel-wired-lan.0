From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:26:56 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 06/11] iavf: Move
 commands processing to the separate function
In-Reply-To: <20190514173709.62431-6-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB748@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 06/11] iavf: Move commands
> processing to the separate function
> 
> From: Jakub Pawlak <jakub.pawlak@intel.com>
> 
> Move the commands processing outside the watchdog_task() function. This
> reduce length and complexity of the function which is mainly designed to
> process the watchdog state machine.
> 
> Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 197 +++++++++++---------
>  1 file changed, 105 insertions(+), 92 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


