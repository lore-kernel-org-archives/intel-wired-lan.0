From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:23:24 +0000
Subject: [Intel-wired-lan] [next PATCH S3 4/9] i40e: ShadowRAM checksum
 calculation change
In-Reply-To: <20190228175255.54754-4-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
 <20190228175255.54754-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3676F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, February 28, 2019 9:53 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Paczkowski, Maciej <maciej.paczkowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S3 4/9] i40e: ShadowRAM checksum
> calculation change
> 
> From: Maciej Paczkowski <maciej.paczkowski@intel.com>
> 
> Due to changes in FW the SW is required to perform double SR dump in some
> cases.
> 
> Implementation adds two new steps to update nvm checksum function:
> * recalculate checksum and check if checksum in NVM is correct
> * if checksum in NVM is not correct then update it again
> 
> Signed-off-by: Maciej Paczkowski <maciej.paczkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 29 +++++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


