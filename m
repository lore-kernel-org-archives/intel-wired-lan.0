From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:23:38 +0000
Subject: [Intel-wired-lan] [PATCH 3/8] ice: add support for set/get of
 driver-stored firmware parameters
In-Reply-To: <20210520164850.1884656-4-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-4-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB5105330ACDFA533E6CA51678FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, May 20, 2021 9:49 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Lion, Sean <sean.lion@intel.com>
> Subject: [Intel-wired-lan] [PATCH 3/8] ice: add support for set/get of driver-
> stored firmware parameters
> 
> Depending on the device configuration, the ice hardware may share the PTP
> hardware clock timer between multiple PFs. Each PF is informed by firmware
> during initialization of the PTP timer association.
> 
> When bringing up PTP, only the PFs which own the timer shall allocate a PTP
> hardware clock. Other PFs associated with that timer must report the correct
> PTP clock index in order to allow userspace software the ability to know
> which ports are connected to the same clock.
> 
> To support this, the firmware has driver shared parameters. These
> parameters enable one PF to write the clock index into firmware, and have
> other PFs read the associated value out. This enables the driver to have only
> a single PF allocate and control the device timer registers, while other PFs
> associated with that timer can report the correct clock in the
> ETHTOOL_GET_TS_INFO report.
> 
> Add support for the necessary admin queue commands to enable reading
> and writing of the driver shared parameters. This will be used in a future
> change to enable sharing the PTP clock index between PF drivers.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 27 +++++++
>  drivers/net/ethernet/intel/ice/ice_common.c   | 75
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_common.h   |  6 ++
>  3 files changed, 108 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


