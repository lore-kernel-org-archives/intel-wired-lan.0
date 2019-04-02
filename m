From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Apr 2019 18:42:23 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/2] ixgbe: add tracking of AF_XDP
 zero-copy state for each queue pair
In-Reply-To: <20190322211638.28545-1-jeffrey.t.kirsher@intel.com>
References: <20190322211638.28545-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D378623@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, March 22, 2019 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/2] ixgbe: add tracking of AF_XDP zero-
> copy state for each queue pair
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Here, we add a bitmap to the ixgbe_adapter that tracks if a certain queue
> pair has been "zero-copy enabled" via the ndo_bpf.
> The bitmap is used in ixgbe_xsk_umem, and enables zero-copy if and only if
> XDP is enabled, the corresponding qid in the bitmap is set, and the umem is
> non-NULL;
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
> v2: fixed merge issues with the current next-queue tree
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 5 ++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


