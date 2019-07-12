From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 17:44:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: added support for NVM update
 via ixgbe driver
In-Reply-To: <20190703104426.3515-1-piotrx.skajewski@intel.com>
References: <20190703104426.3515-1-piotrx.skajewski@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AB6E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Piotr Skajewski
> Sent: Wednesday, July 3, 2019 3:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Skajewski, PiotrX <piotrx.skajewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: added support for NVM update via
> ixgbe driver
> 
> When Secure Boot is enabled access to the /dev/mem is forbidden for user-
> space applications and clients are reporting inability to use tools in Secure
> Boot Mode. The way to perform NVM update is to use ixgbe driver.
> Currently 10G Linux Base Driver has API which allows only EEPROM access.
> There is a need to extend IOCTL API to allow NVM and registers access.
> 
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  38 ++++++
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  17 +++
>  .../net/ethernet/intel/ixgbe/ixgbe_common.h   |   3 +
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  74 +++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   3 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  50 +++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  41 ++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 129 ++++++++++++++++++
>  8 files changed, 346 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


