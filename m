From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Jun 2017 16:51:38 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 06/13] i40e: Support
 firmware	CEE DCB UP to TC map re-definition
In-Reply-To: <20170607094313.32060-6-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAAB3C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Bowers, Gregory J <gregory.j.bowers@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S72-V3 06/13] i40e: Support firmware
> CEE DCB UP to TC map re-definition
> 
> Changes parsing of FW 4.33 AQ command Get CEE DCBX OPER CFG (0x0A07).
> Change is required because FW now creates the oper_prio_tc nibbles
> reversed from those in the CEE Priority Group sub-TLV.
> This change will only apply to FW 4.33 as future FW versions will use a
> different function to parse the CEE data.
> 
> Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


