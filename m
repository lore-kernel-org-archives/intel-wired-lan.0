From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jun 2020 19:24:38 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add ethtool support to enable
 2.5 and 5.0 Gbps support
In-Reply-To: <20200626132814.41471-1-radoslawx.tyl@intel.com>
References: <20200626132814.41471-1-radoslawx.tyl@intel.com>
Message-ID: <DM5PR1101MB2154DA0B444E1E9AAB65D6CB8C930@DM5PR1101MB2154.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Radoslaw Tyl
> Sent: Friday, June 26, 2020 6:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Tyl, RadoslawX
> <radoslawx.tyl@intel.com>; Skajewski, PiotrX <piotrx.skajewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add ethtool support to enable 2.5
> and 5.0 Gbps support
> 
> Added full support for new version Ethtool API. New API allow use
> 2500Gbase-T and 5000base-T supported and advertised link speed modes.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 262 ++++++++++++------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   6 +-
>  2 files changed, 183 insertions(+), 85 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


