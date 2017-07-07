From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Jul 2017 17:18:17 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Clear SWFW_SYNC register
 during	init
In-Reply-To: <20170705225730.8377.3240.stgit@localhost6.localdomain6>
References: <20170705225730.8377.3240.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB14BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, July 5, 2017 3:58 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Clear SWFW_SYNC register
> during init
> 
> Added clearing of SW resource bits in the SW/FW synchronization register to
> ixgbe_init_swfw_sync_X540().
> 
> Updated ixgbe_acquire_swfw_sync_X540 SW Manageability host interface
> resource bit error case to match the error handling of the other SW resource
> bits. Which is to release the SW resource bits if SW times out while
> attempting to acquire the resource.
> 
> This allows the driver to load in cases where the semaphore bits could be
> stuck after a reset or a crash.
> 
> -v2 - fixed title
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


