From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Aug 2020 00:34:19 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add flow director support for
 IPv6
In-Reply-To: <20200806133631.10940-1-arkadiusz.kubalewski@intel.com>
References: <20200806133631.10940-1-arkadiusz.kubalewski@intel.com>
Message-ID: <BN6PR1101MB21458907F339A9DFBB7383758C490@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Thursday, August 6, 2020 6:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Add flow director support for IPv6
> 
> From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> 
> Flow director for IPv6 is not supported.
> Implementation of support for IPv6 flow director. Added handlers for
> addition of TCP6, UDP6, SCTP6, IPv6. Refactored legacy code to make it more
> generic. Added packet templates for TCP6, UDP6, SCTP6, IPv6.
> Added handling of IPv6 source and destination addres for flow director.
> Improved argument passing for source and destination port in TCP6, UDP6
> and SCTP6. Added handling of ethtool -n for IPv6, TCP6, UDP6, SCTP6. Used
> correct bit flag regarding FLEXOFF field of flow director data descriptor.
> Without this patch, there would be no support for flow director on IPv6,
> TCP6, UDP6, SCTP6.
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |   9 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 210 +++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  79 +++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 371 +++++++++++++-----
>  4 files changed, 550 insertions(+), 119 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


