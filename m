From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 7 Dec 2016 23:20:47 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix AER error handling
In-Reply-To: <20161116174802.11222.68715.stgit@localhost6.localdomain6>
References: <20161116174802.11222.68715.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39965@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, November 16, 2016 9:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix AER error handling
> 
> Make sure that we free the IRQs in ixgbe_io_error_detected() when
> responding to an PCIe AER error and also restore them when the interface
> recovers from it.
> 
> Previously it was possible to trigger BUG_ON() check in free_msix_irqs() in
> the case where we call ixgbe_remove() after a failed recovery from AER
> error because the inerrupts were not freed.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


