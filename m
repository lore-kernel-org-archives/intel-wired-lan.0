From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 10 Apr 2017 21:38:08 +0000
Subject: [Intel-wired-lan] [next S68 01/01] i40e/i40evf: Remove VF Rx
 csum	offload for tunneled packets.
In-Reply-To: <20170406095934.70094-1-alice.michael@intel.com>
References: <20170406095934.70094-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B51A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 6, 2017 3:00 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S68 01/01] i40e/i40evf: Remove VF Rx csum
> offload for tunneled packets.
> 
> Rx checksum offload for tunneled packets was never being negotiated or
> requested by VF. This capability was assumed by default and enabled in
> current hardware for VF. Going forward, this feature needs to be disabled or
> advanced ptypes should be negotiated with PF in the future.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Change-ID: I9e54cfa8a90e03ab6956db4412f1e337ccd2c2e0
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 7 -------
>  1 file changed, 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


