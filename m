From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Fri, 6 May 2022 16:21:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Expose RSS
 indirection tables for queue groups via ethtool
In-Reply-To: <20220503161339.2287738-1-sudheer.mogilappagari@intel.com>
References: <20220503161339.2287738-1-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB361456918E18D6D4DCEDCB5A8EC59@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sudheer Mogilappagari
> Sent: Tuesday, May 3, 2022 9:44 PM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Expose RSS indirection
> tables for queue groups via ethtool
> 
> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> When ADQ queue groups (TCs) are created via tc mqprio command, RSS
> contexts and associated RSS indirection tables are configured automatically
> per TC based on the queue ranges specified for each traffic class.
> 
> For ex:
> tc qdisc add dev enp175s0f0 root mqprio num_tc 3 map 0 1 2 \
> 	queues 2 at 0 8 at 2 4 at 10 hw 1 mode channel
> 
> will create 3 queue groups (TC 0-2) with queue ranges 2, 8 and 4 in 3 queue
> groups. Each queue group is associated with its own RSS context and RSS
> indirection table.
> 
> Add support to expose RSS indirection tables for all ADQ queue groups using
> ethtool RSS contexts interface.
> 	ethtool -x enp175s0f0 context <tc-num>
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
> v2:
> -Updated commit message based on Paul's review comments.
> 
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 69 +++++++++++++++-----
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
