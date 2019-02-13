From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:14:44 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 02/12] i40e: Implement DDP
 support in i40e driver
In-Reply-To: <20190206230826.24970-2-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365FA0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 02/12] i40e: Implement DDP
> support in i40e driver
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This patch introduces DDP (Dynamic Device Personalization) which allows
> loading profiles that change the way internal parser interprets processed
> frames. To load DDP profiles it utilizes ethtool flash feature. The files with
> recipes must be located in /var/lib/firmware directory. Afterwards the recipe
> can be loaded by invoking:
> 
>     ethtool -f <if_name> <file_name> 100
>     ethtool -f <if_name> - 100
> 
> See further usage details of this feature in the i40e documentation, or visit
> https://software.intel.com/en-us/articles/dynamic-device-personalization-
> for-intel-ethernet-700-series
> 
> The driver shall verify DDP profile can be loaded in accordance with the rules:
> * Package with Group ID 0 are exclusive and can only be loaded the first.
> * Packages with Group ID 0x01-0xFE can only be loaded simultaneously
>    with the packages from the same group.
> * Packages with Group ID 0xFF are compatible with all other packages.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/Makefile      |   1 +
>  drivers/net/ethernet/intel/i40e/i40e.h        |  25 +
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 253 ++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 481 ++++++++++++++++++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 +
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |   6 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  23 +
>  8 files changed, 769 insertions(+), 22 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/i40e/i40e_ddp.c

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


