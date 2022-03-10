From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Thu, 10 Mar 2022 18:14:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] ice: Add inline flow
 director support for channels
In-Reply-To: <20220310103959.369773-3-sudheer.mogilappagari@intel.com>
References: <20220310103959.369773-1-sudheer.mogilappagari@intel.com>
 <20220310103959.369773-3-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB3614BDF434FF5770804A67F58E0B9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sudheer Mogilappagari
> Sent: Thursday, March 10, 2022 4:10 PM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] ice: Add inline flow
> director support for channels
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Inline flow director allows uniform distribution of flows among a queue
> group (TC). At first, a queue is chosen at random from the group of queues
> for the first flow and subsequent queue is used for next flow and wrapping
> around as needed.
> 
> Inline flow director can be configured for each TC via devlink params based
> interface.
> 
> /* Create 4 TCs */
> tc qdisc add dev enp175s0f0 root mqprio num_tc 4 map 0 1 2 3 \
>              queues 2 at 0 8 at 2 8 at 10 8 at 18 hw 1 mode channel
> 
> /* Enable inline flow director for TC1 and TC2 */ devlink dev param set
> pci/0000:af:00.0 \
>         name tc_inline_fd value 6 cmode runtime
> 
> /* Dump inline flow director setting */
> devlink dev param show  pci/0000:af:00.0 name tc_inline_fd
> pci/0000:af:00.0:
>   name tc2_inline_fd type driver-specific
>     values:
>       cmode runtime value 6
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  82 +++++
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  11 +
>  drivers/net/ethernet/intel/ice/ice_devlink.c  | 130 ++++++++
>  drivers/net/ethernet/intel/ice/ice_devlink.h  |   2 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  25 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   5 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   3 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 173 ++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 294 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   8 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  13 files changed, 729 insertions(+), 7 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>

