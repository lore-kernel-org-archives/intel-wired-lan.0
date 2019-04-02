From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Apr 2019 18:42:51 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] ixgbe: remove umem from adapter
In-Reply-To: <20190322211638.28545-2-jeffrey.t.kirsher@intel.com>
References: <20190322211638.28545-1-jeffrey.t.kirsher@intel.com>
 <20190322211638.28545-2-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D378633@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 2/2] ixgbe: remove umem from adapter
> 
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> As current implementation of netdev already contains and provides umems
> for us, we no longer have the need to contain these structures in
> ixgbe_adapter.
> 
> Refactor the code to operate on netdev-provided umems.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
> v2: fixed merge issues with the current next-queue tree
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h     | 11 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 79 ++++----------------
>  2 files changed, 19 insertions(+), 71 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


