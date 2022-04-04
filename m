From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Mon, 4 Apr 2022 08:28:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Add support for
 classid based queue selection
In-Reply-To: <20220318055549.76343-1-sudheer.mogilappagari@intel.com>
References: <20220318055549.76343-1-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB3614E9C8FBB1EABCB691D4B28EE59@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sudheer Mogilappagari
> Sent: Friday, March 18, 2022 11:26 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Add support for classid
> based queue selection
> 
> From: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> This patch uses TC flower filter's classid feature to support forwarding
> packets to a device queue. Such filters with action forward to queue will be
> the highest priority switch filter in HW.
> Example:
> $ tc filter add dev ens4f0 protocol ip ingress flower\
>   dst_ip 192.168.1.12 ip_proto tcp dst_port 5001\
>   skip_sw classid ffff:0x5
> 
> The above command adds an ingress filter, the accepted packets will be
> directed to queue 4. The major number represents the ingress qdisc. The
> general rule is "classID's minor number - 1" upto max queues supported. The
> queue number is in hex format.
> 
> Refactored ice_add_tc_flower_adv_fltr() to consolidate code with action
> FWD_TO_VSI and FWD_TO QUEUE.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
> 
> v2:
> - fixed use of global queue id instead of PF relative queue id
>   as requred by hw.
> 
> ---
> 
>  drivers/net/ethernet/intel/ice/ice.h        |  15 ++
>  drivers/net/ethernet/intel/ice/ice_main.c   |   2 +-
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 274 +++++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_tc_lib.h |  40 ++-
>  4 files changed, 263 insertions(+), 68 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
