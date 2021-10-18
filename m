From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Mon, 18 Oct 2021 16:06:49 +0000
Subject: [Intel-wired-lan] [PATCH net-next 3/3] ice: Add tc-flower
 filter support for channel
In-Reply-To: <20211011192518.1867431-4-sudheer.mogilappagari@intel.com>
References: <20211011192518.1867431-1-sudheer.mogilappagari@intel.com>
 <20211011192518.1867431-4-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB3614AB15A5ADC354C6BF89FA8EBC9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> sudheer.mogilappagari at intel.com
> Sent: Tuesday, October 12, 2021 12:55 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 3/3] ice: Add tc-flower filter
> support for channel
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add support to add/delete channel specific filter using tc-flower.
> For now, only supported action is "skip_sw hw_tc <tc_num>"
> 
> Filter criteria is specific to channel and it can be combination of L3, L3+L4,
> L2+L4.
> 
> Example:
> MATCH criteria       Action
> ---------------------------
> src and/or dest IPv4[6]/mask -> Forward to "hw_tc <tc_num>"
> dest IPv4[6]/mask + dest L4 port -> Forward to "hw_tc <tc_num>"
> dest MAC + dest L4 port -> Forward to "hw_tc <tc_num>"
> src IPv4[6]/mask + src L4 port -> Forward to "hw_tc <tc_num>"
> src MAC + src L4 port -> Forward to "hw_tc <tc_num>"
> 
> Adding tc-flower filter for channel using "hw_tc"
> -------------------------------------------------
> tc qdisc add dev <ethX> clsact
> 
> Above two steps are only needed the first time when adding tc-flower filter.
> 
> tc filter add dev <ethX> protocol ip ingress prio 1 flower \
>      dst_ip 192.168.0.1/32 ip_proto tcp dst_port 5001 \
>      skip_sw hw_tc 1
> 
> tc filter show dev <ethX> ingress
> filter protocol ip pref 1 flower chain 0 filter protocol ip pref 1 flower chain 0
> handle 0x1 hw_tc 1
>   eth_type ipv4
>   ip_proto tcp
>   dst_ip 192.168.0.1
>   dst_port 5001
>   skip_sw
>   in_hw in_hw_count 1
> 
> Delete specific filter:
> -------------------------
> tc filter del  dev <ethx> ingress pref 1 handle 0x1 flower
> 
> Delete All filters:
> ------------------
> tc filter del dev <ethX> ingress
> 
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h        |   9 +-
>  drivers/net/ethernet/intel/ice/ice_main.c   |  77 ++++++-
>  drivers/net/ethernet/intel/ice/ice_switch.c | 119 +++++++++++
>  drivers/net/ethernet/intel/ice/ice_switch.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 217 +++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |  22 ++
>  6 files changed, 438 insertions(+), 8 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
