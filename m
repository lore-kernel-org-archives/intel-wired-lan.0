From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:26:04 +0000
Subject: [Intel-wired-lan] [PATCH 6/8] ice: report the PTP clock index
 in ethtool .get_ts_info
In-Reply-To: <20210520164850.1884656-7-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-7-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB510508131296CE9BE64F4665FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 6/8] ice: report the PTP clock index in
> ethtool .get_ts_info
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
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 132 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h     |   5 +
>  3 files changed, 158 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


