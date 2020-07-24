From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jul 2020 23:53:32 +0000
Subject: [Intel-wired-lan] [PATCH S48 v6 02/16] ice: Add more basic
 protocol support for flow filter
In-Reply-To: <20200716133938.46921-3-qi.z.zhang@intel.com>
References: <20200716133938.46921-1-qi.z.zhang@intel.com>
 <20200716133938.46921-3-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB2145193F6D0AFBB9F52796798C770@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 16, 2020 6:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v6 02/16] ice: Add more basic protocol
> support for flow filter
> 
> Add more protocol and field support for flow filter include:
> ETH, VLAN, ICMP, ARP and TCP flag.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c          |  20 +++
>  drivers/net/ethernet/intel/ice/ice_fdir.h          |   1 +
>  drivers/net/ethernet/intel/ice/ice_flow.c          | 181
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h          |  20 +++
>  drivers/net/ethernet/intel/ice/ice_protocol_type.h |   6 +
>  5 files changed, 222 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


