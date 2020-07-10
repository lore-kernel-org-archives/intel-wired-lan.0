From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:30:47 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 02/16] ice: Add more basic
 protocol support for flow filter
In-Reply-To: <20200710010644.33817-3-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-3-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21453C3B02D4B25F0E12C0978C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Qi
> Zhang
> Sent: Thursday, July 9, 2020 6:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Zhang, Qi Z <qi.z.zhang@intel.com>
> Subject: [Intel-wired-lan] [PATCH S48 v5 02/16] ice: Add more basic protocol
> support for flow filter
> 
> Add more protocol and field support for flow filter include:
> ETH, VLAN, ICMP, ARP and TCP flag.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c          | 181
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h          |  20 +++
>  drivers/net/ethernet/intel/ice/ice_protocol_type.h |   6 +
>  3 files changed, 201 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


