From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Oct 2018 19:37:45 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbe/ixgbevf: fix XFRM_ALGO
 dependency
In-Reply-To: <20181018223943.3709-1-jeffrey.t.kirsher@intel.com>
References: <20181018223943.3709-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D310D5D@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, October 18, 2018 3:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Subject: [Intel-wired-lan] [PATCH v2] ixgbe/ixgbevf: fix XFRM_ALGO
> dependency
> 
> Based on the original work from Arnd Bergmann.
> 
> When XFRM_ALGO is not enabled, the new ixgbe IPsec code produces a link
> error:
> 
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function
> `ixgbe_ipsec_vf_add_sa':
> ixgbe_ipsec.c:(.text+0x1266): undefined reference to
> `xfrm_aead_get_byname'
> 
> Simply selecting XFRM_ALGO from here causes circular dependencies, so to
> fix it, we probably want this slightly more complex solution that is similar to
> what other drivers with XFRM offload do:
> 
> A separate Kconfig symbol now controls whether we include the IPsec
> offload code. To keep the old behavior, this is left as 'default y'. The
> dependency in XFRM_OFFLOAD still causes a circular dependency but is not
> actually needed because this symbol is not user visible, so removing that
> dependency on top makes it all work.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: fixed spelling errors, also added the changes to ixgbevf driver as
>     well
> 
>  drivers/net/ethernet/intel/Kconfig             | 18 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/Makefile      |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  8 ++++----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 +++---
>  drivers/net/ethernet/intel/ixgbevf/Makefile    |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h   |  4 ++--
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  2 +-
>  net/xfrm/Kconfig                               |  1 -
>  8 files changed, 30 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


