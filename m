From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 22:00:05 +0000
Subject: [Intel-wired-lan] [next PATCH S4 11/11] i40e: Revert ShadowRAM
 checksum calculation change
In-Reply-To: <20190329220840.51187-11-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
 <20190329220840.51187-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D37882F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Paczkowski, Maciej <maciej.paczkowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 11/11] i40e: Revert ShadowRAM
> checksum calculation change
> 
> From: Maciej Paczkowski <maciej.paczkowski@intel.com>
> 
> The reason of this revert is unexpected issue found in NVM Update tool
> during NVM image downgrade. The implementation is no longer needed
> since the QV tools are already aware of new FW double ShadowRAM dump
> mechanism.
> 
> This patch reverts ShadowRAM checksum calculation change introduced in
> commit 9d12f0c4e436 ("i40e: Revert ShadowRAM checksum calculation
> change")
> 
> Signed-off-by: Maciej Paczkowski <maciej.paczkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 28 +++-------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


