From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Mon, 18 Oct 2021 16:04:02 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ice: enable ndo_setup_tc
 support for mqprio_qdisc
In-Reply-To: <20211011192518.1867431-3-sudheer.mogilappagari@intel.com>
References: <20211011192518.1867431-1-sudheer.mogilappagari@intel.com>
 <20211011192518.1867431-3-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB3614BD3DA1E50DC6F2932B4A8EBC9@MN2PR11MB3614.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 2/3] ice: enable ndo_setup_tc
> support for mqprio_qdisc
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add support in driver for TC_QDISC_SETUP_MQPRIO. This support enables
> instantiation of channels in HW using existing MQPRIO infrastructure which is
> extended to be offloadable. This provides a mechanism to configure
> dedicated set of queues for each TC.
> 
> Configuring channels using "tc mqprio":
> --------------------------------------
> tc qdisc add dev <ethX> root mqprio num_tc 3 map 0 1 2 \
> 	queues 4 at 0 4 at 4 4 at 8  hw 1 mode channel
> 
> Above command configures 3 TCs having 4 queues each. "hw 1 mode
> channel"
> implies offload of channel configuration to HW. When driver processes
> configuration received via "ndo_setup_tc: QDISC_SETUP_MQPRIO", each TC
> maps to HW VSI with specified queues.
> 
> User can optionally specify bandwidth min and max rate limit per TC (see
> example below). If shaper params like min and/or max bandwidth rate limit
> are specified, driver configures VSI specific rate limiter in HW.
> 
> Configuring channels and bandwidth shaper parameters using "tc mqprio":
> ----------------------------------------------------------------
> tc qdisc add dev <ethX> root mqprio \
> 	num_tc 4 map 0 1 2 3 queues 4 at 0 4 at 4 4 at 8 4 at 12 hw 1 mode
> channel \
> 	shaper bw_rlimit min_rate 1Gbit 2Gbit 3Gbit 4Gbit \
> 	max_rate 4Gbit 5Gbit 6Gbit 7Gbit
> 
> Command to view configured TCs:
> -----------------------------
> tc qdisc show dev <ethX>
> 
> Deleting TCs:
> ------------
> tc qdisc del dev <ethX> root mqprio
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  21 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  10 +
>  drivers/net/ethernet/intel/ice/ice_lib.c     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c    | 894 ++++++++++++++++++-
>  5 files changed, 919 insertions(+), 10 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
