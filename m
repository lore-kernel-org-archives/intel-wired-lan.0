From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 10 Jun 2021 21:20:31 +0000
Subject: [Intel-wired-lan] [PATCH v2 6/8] ice: report the PTP clock
 index in ethtool .get_ts_info
In-Reply-To: <20210609163953.52440-7-anthony.l.nguyen@intel.com>
References: <20210609163953.52440-1-anthony.l.nguyen@intel.com>
 <20210609163953.52440-7-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51050F7A582B08C6A5F84328FA359@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, June 9, 2021 9:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 6/8] ice: report the PTP clock index in
> ethtool .get_ts_info
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Now that the driver registers a PTP clock device that represents the clock
> hardware, it is important that the clock index is reported via the ethtool
> .get_ts_info callback.
> 
> The underlying hardware resource is shared between multiple PF functions.
> Only one function owns the hardware resources associated with a timer, but
> multiple functions may be associated with it for the purposes of
> timestamping.
> 
> To support this, the owning PF will store the clock index into the driver
> shared parameters buffer in firmware. Other PFs will look up the clock index
> by reading the driver shared parameter on demand when requested via the
> .get_ts_info ethtool function.
> 
> In this way, all functions which are tied to the same timer are able to report
> the clock index. Userspace software such as ptp4l performs a look up on the
> netdev to determine the associated clock, and all commands to control or
> configure the clock will be handled through the controlling PF.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  22 +++-
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 129 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h     |   5 +
>  3 files changed, 155 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


