From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2020 20:10:56 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Allow changing FEC settings on
 X722 if supported by FW
In-Reply-To: <20200724122356.24058-1-arkadiusz.kubalewski@intel.com>
References: <20200724122356.24058-1-arkadiusz.kubalewski@intel.com>
Message-ID: <BN6PR1101MB21457755A765EB31F827D2898C730@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Friday, July 24, 2020 5:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Gawin,
> JaroslawX <jaroslawx.gawin@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Allow changing FEC settings on X722
> if supported by FW
> 
> From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> 
> Starting with API version 1.10 firmware for X722 devices has ability to change
> FEC settings in PHY. Code added in this patch allows changing FEC settings if
> the capability flag indicates the device supports this feature.
> 
> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c |  6 +++++
> .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 ++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 22 ++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 19 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  1 +
>  5 files changed, 47 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


