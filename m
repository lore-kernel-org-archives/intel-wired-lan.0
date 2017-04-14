From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Apr 2017 21:46:46 +0000
Subject: [Intel-wired-lan] [next PATCH S70 03/12] i40e: don't hold RTNL
 lock	while waiting for VF reset to finish
In-Reply-To: <20170413084555.6962-3-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B9E2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 03/12] i40e: don't hold RTNL lock
> while waiting for VF reset to finish
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We made some effort to reduce the RTNL lock scope when resetting and
> rebuilding the PF. Unfortunately we still held the RTNL lock during the VF
> reset operation, which meant that multiple PFs could not reset in parallel due
> to the global lock. For now, further reduce the scope by not holding the RTNL
> lock while resetting VFs. This allows multiple PFs to reset in a timely manner.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I2fbf823a0063f24dff67676cad09f0bbf83ee4ce
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


