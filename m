From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Wed, 2 Mar 2022 11:44:44 +0000
Subject: [Intel-wired-lan] [net-next PATCH v1] ice: Add support for
 outer dest MAC for ADQ tunnels
In-Reply-To: <164436876576.5021.7903773697130184451.stgit@anambiarhost.jf.intel.com>
References: <164436876576.5021.7903773697130184451.stgit@anambiarhost.jf.intel.com>
Message-ID: <MN2PR11MB36140AB5C673FC6D671084518E039@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Amritha Nambiar
> Sent: Wednesday, February 9, 2022 6:36 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v1] ice: Add support for outer dest
> MAC for ADQ tunnels
> 
> TC flower does not support matching on user specified outer MAC address for
> tunnels. For ADQ tunnels, the driver adds outer destination MAC address as
> lower netdev's active unicast MAC address to filter out packets with unrelated
> MAC address being delivered to ADQ VSIs.
> 
> Example:
> - create tunnel device
> ip l add $VXLAN_DEV type vxlan id $VXLAN_VNI dstport $VXLAN_PORT \ dev $PF
> - add TC filter (in ADQ mode)
> 
> $tc filter add dev $VXLAN_DEV protocol ip parent ffff: flower \  dst_ip
> $INNER_DST_IP ip_proto tcp dst_port $INNER_DST_PORT \  enc_key_id
> $VXLAN_VNI hw_tc $ADQ_TC
> 
> Note: Filters with wild-card tunnel ID (when user does not specify tunnel key) are
> also supported.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c |   30 ++++++++++++++++++++++++--
> -
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
