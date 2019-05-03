From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:40:27 +0000
Subject: [Intel-wired-lan] [next PATCH S5 10/10] i40e: Missing response
 checks in driver when starting/stopping FW LLDP
In-Reply-To: <20190424122055.27896-10-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C70D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 10/10] i40e: Missing response
> checks in driver when starting/stopping FW LLDP
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Driver updated pf->flags before calling i40e_aq_start_lldp().
> This patch moved down updating pf->flags down so flags will be updated
> only in case of successful i40e_aq_start_lldp() call.
> Also was introduced is_reset_needed local flag to avoid unnecessary h/w
> reset in case 40e_aq_start_lldp() didn't change lldp state.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 45 ++++++++++---------
>  1 file changed, 24 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


