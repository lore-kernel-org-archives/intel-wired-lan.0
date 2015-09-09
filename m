From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Sep 2015 21:52:47 +0000
Subject: [Intel-wired-lan] [next PATCH S13 06/15] i40e: Support FW CEE
 DCB	UP to TC map nibble swap
In-Reply-To: <1440798961-17326-7-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
 <1440798961-17326-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5EB5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Friday, August 28, 2015 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bowers, Gregory J
> Subject: [Intel-wired-lan] [next PATCH S13 06/15] i40e: Support FW CEE DCB
> UP to TC map nibble swap
> 
> From: Greg Bowers <gregory.j.bowers@intel.com>
> 
> Changes parsing of AQ command Get CEE DCBX OPER CFG (0x0A07). Change
> is required because FW creates the oper_prio_tc nibbles reversed from
> those in the CEE Priority Group sub-TLV.
> 
> Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
> Change-ID: I7d9d8641bb430d30e286fc3fac909866ef8a0de8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
