From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:44:40 +0000
Subject: [Intel-wired-lan] [next S66 v2 08/11] i40e: clean up
	historic	deprecated flag definitions
In-Reply-To: <20170405115103.67374-8-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B17F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 08/11] i40e: clean up historic
> deprecated flag definitions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Since an early commit a few flags have no longer been used. Remove these
> definitions to reduce code clutter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I3589be4622574e747013cd4dc403e18b039f4965
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


