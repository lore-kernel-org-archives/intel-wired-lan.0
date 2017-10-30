From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 19:01:56 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 6/6] i40e:
 Enable cloud filters via tc-flower
In-Reply-To: <150909696126.48377.794676088838721605.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909696126.48377.794676088838721605.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADBC0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, October 27, 2017 2:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: jiri at resnulli.us; netdev at vger.kernel.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 6/6] i40e: Enable
> cloud filters via tc-flower
> 
> This patch enables tc-flower based hardware offloads. tc flower
> filter provided by the kernel is configured as driver specific
> cloud filter. The patch implements functions and admin queue
> commands needed to support cloud filters in the driver and
> adds cloud filters to configure these tc-flower filters.
> 
> The classification function of the filter is to direct matched
> packets to a traffic class. The hardware traffic class is set
> based on the the classid reserved in the range :ffe0 - :ffef.
> 
> # tc qdisc add dev eth0 ingress
> # ethtool -K eth0 hw-tc-offload on
> 
> Match Dst MAC and route to TC0:
> # tc filter add dev eth0 protocol ip parent ffff:\
>   prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 skip_sw\
>   hw_tc 1
> 
> Match Dst IPv4,Dst Port and route to TC1:
> # tc filter add dev eth0 protocol ip parent ffff:\
>   prio 2 flower dst_ip 192.168.3.5/32\
>   ip_proto udp dst_port 25 skip_sw\
>   hw_tc 2
> 
> Match Dst IPv6,Dst Port and route to TC1:
> # tc filter add dev eth0 protocol ipv6 parent ffff:\
>   prio 3 flower dst_ip fe8::200:1\
>   ip_proto udp dst_port 66 skip_sw\
>   hw_tc 2
> 
> Delete tc flower filter:
> Example:
> 
> # tc filter del dev eth0 parent ffff: prio 3 handle 0x1 flower
> # tc filter del dev eth0 parent ffff:
> 
> Flow Director Sideband is disabled while configuring cloud filters
> via tc-flower and until any cloud filter exists.
> 
> Unsupported matches when cloud filters are added using enhanced
> big buffer cloud filter mode of underlying switch include:
> 1. source port and source IP
> 2. Combined MAC address and IP fields.
> 3. Not specifying L4 port
> 
> These filter matches can however be used to redirect traffic to
> the main VSI (tc 0) which does not require the enhanced big buffer
> cloud filter support.
> 
> v5: Changes to align with Jiri's filter-block series. Use the
> helper function to get the HW traffic class value from classid.
> Pack cloud filter struct and other code cleanup based on Shannon's
> comments.
> v4: Use classid to set traffic class for matched packets. Do not
> allow disabling hw-tc-offloads when offloaded tc filters are active.
> v3: Cleaned up some lengthy function names. Changed ipv6 address to
> __be32 array instead of u8 array. Used macro for IP version. Minor
> formatting changes.
> v2:
> 1. Moved I40E_SWITCH_MODE_MASK definition to i40e_type.h
> 2. Moved dev_info for add/deleting cloud filters in else condition
> 3. Fixed some format specifier in dev_err logs
> 4. Refactored i40e_get_capabilities to take an additional
>    list_type parameter and use it to query device and function
>    level capabilities.
> 5. Fixed parsing tc redirect action to check for the is_tcf_mirred_tc()
>    to verify if redirect to a traffic class is supported.
> 6. Added comments for Geneve fix in cloud filter big buffer AQ
>    function definitions.
> 7. Cleaned up setup_tc interface to rebase and work with Jiri's
>    updates, separate function to process tc cls flower offloads.
> 8. Changes to make Flow Director Sideband and Cloud filters mutually
>    exclusive.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   54 +
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |    3
>  drivers/net/ethernet/intel/i40e/i40e_common.c      |  189 ++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  957
> +++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   16
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |    1
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |    3
>  7 files changed, 1192 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


