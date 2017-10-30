From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 21:51:42 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: extend firmware version support
In-Reply-To: <1509114760-7626-1-git-send-email-paul.greenwalt@intel.com>
References: <1509114760-7626-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADC08@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Friday, October 27, 2017 7:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: extend firmware version support
> 
> Extend FW version reporting by displaying information from the iSCSI or OEM
> block in the EEPROM.
> 
> This will allow us to more accurately identify the FW.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   3 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  | 112
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h  |   6 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   7 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c    |   7 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  38 +++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  39 ++++++++
>  7 files changed, 198 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


