From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 10 Jul 2020 21:29:56 +0000
Subject: [Intel-wired-lan] [PATCH S48 v5 06/16] ice: Enhanced IPv4 and
 IPv6 flow filter
In-Reply-To: <20200710010644.33817-7-qi.z.zhang@intel.com>
References: <20200710010644.33817-1-qi.z.zhang@intel.com>
 <20200710010644.33817-7-qi.z.zhang@intel.com>
Message-ID: <BN6PR1101MB21452CDC338C1E057ED8DFEC8C650@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S48 v5 06/16] ice: Enhanced IPv4 and IPv6
> flow filter
> 
> Separate IPv4 and IPv6 ptype bit mask table into 2 tables:
> With or without L4 protocols.
> 
> When a flow filter without any l4 type is specified, the
> ICE_FLOW_SEG_HDR_IPV_OTHER flag can be used to describe if user want to
> create a IP rule target for all IP packet or just IP packet without l4 header.
> 
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.c | 111
> ++++++++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_flow.h |   4 ++
>  2 files changed, 111 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


