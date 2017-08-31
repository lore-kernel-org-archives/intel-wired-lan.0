From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 19:01:11 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 03/13] i40e: re-enable PTP
 L4	capabilities for XL710 if FW >6.0
In-Reply-To: <20170829093242.41026-3-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA94E0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S79-V2 03/13] i40e: re-enable PTP L4
> capabilities for XL710 if FW >6.0
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Starting with XL710 FW 5.3 PTP L4 was disabled for XL710 due to a bug.  The
> bug has since been resolved in XL710 FW >6.0 and PTP L4 can now be re-
> enabled on those devices with updated firmware.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


