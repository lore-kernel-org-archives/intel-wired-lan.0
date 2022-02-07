From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 7 Feb 2022 20:32:21 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: fix IPIP and SIT TSO
 offload
In-Reply-To: <20220114233839.67979-1-jesse.brandeburg@intel.com>
References: <20220114233839.67979-1-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB3367141D5AA953CA64369E7EFC2C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Saturday, January 15, 2022 5:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v1] ice: fix IPIP and SIT TSO offload
> 
> The driver was avoiding offload for IPIP (at least) frames due to parsing the
> inner header offsets incorrectly when trying to check lengths.
> 
> This length check works for VXLAN frames but fails on IPIP frames because
> skb_transport_offset points to the inner header in IPIP frames, which meant
> the subtraction of transport_header from inner_network_header returns a
> negative value (-20).
> 
> With the code before this patch, everything continued to work, but GSO was
> being used to segment, causing throughputs of 1.5Gb/s per thread.
> After this patch, throughput is more like 10Gb/s per thread for IPIP traffic.
> 
> Fixes: e94d44786693 ("ice: Implement filter sync, NDO operations and bump
> version")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> --
> Testing Hints: test IPIP tunnel and VXLAN tunnel, both should use TSO.
> ---
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 25 +++++++++++++------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
