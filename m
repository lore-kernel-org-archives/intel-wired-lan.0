From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 27 May 2021 17:26:45 +0000
Subject: [Intel-wired-lan] [PATCH 7/8] ice: enable receive hardware
 timestamping
In-Reply-To: <20210520164850.1884656-8-jacob.e.keller@intel.com>
References: <20210520164850.1884656-1-jacob.e.keller@intel.com>
 <20210520164850.1884656-8-jacob.e.keller@intel.com>
Message-ID: <CO1PR11MB5105711DC509CFCB29DFEA58FA239@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH 7/8] ice: enable receive hardware
> timestamping
> 
> Add SIOCGHWTSTAMP and SIOCSHWTSTAMP ioctl handlers to respond to
> requests to enable timestamping support. If the request is for enabling Rx
> timestamps, set a bit in the Rx descriptors to indicate that receive
> timestamps should be reported.
> 
> Hardware captures receive timestamps in the PHY which only captures part
> of the timer, and reports only 40 bits into the Rx descriptor. The upper
> 32 bits represent the contents of GLTSYN_TIME_L at the point of packet
> reception, while the lower 8 bits represent the upper 8 bits of
> GLTSYN_TIME_0.
> 
> The networking and PTP stack expect 64 bit timestamps in nanoseconds. To
> support this, implement some logic to extend the timestamps by using the
> full PHC time.
> 
> If the Rx timestamp was captured prior to the PHC time, then the real
> timestamp is
> 
>   PHC - (lower_32_bits(PHC) - timestamp)
> 
> If the Rx timestamp was captured after the PHC time, then the real
> timestamp is
> 
>   PHC + (timestamp - lower_32_bits(PHC))
> 
> These calculations are correct as long as neither the PHC timestamp nor the
> Rx timestamps are more than 2^32-1 nanseconds old. Further, we can detect
> when the Rx timestamp is before or after the PHC as long as the PHC
> timestamp is no more than 2^31-1 nanoseconds old.
> 
> In that case, we calculate the delta between the lower 32 bits of the PHC and
> the Rx timestamp. If it's larger than 2^31-1 then the Rx timestamp must have
> been captured in the past. If it's smaller, then the Rx timestamp must have
> been captured after PHC time.
> 
> Add an ice_ptp_extend_32b_ts function that relies on a cached copy of the
> PHC time and implements this algorithm to calculate the proper upper 32bits
> of the Rx timestamps.
> 
> Cache the PHC time periodically in all of the Rx rings. This enables each Rx ring
> to simply call the extension function with a recent copy of the PHC time. By
> ensuring that the PHC time is kept up to date periodically, we ensure this
> algorithm doesn't use stale data and produce incorrect results.
> 
> To cache the time, introduce a kworker and a kwork item to periodically store
> the Rx time. It might seem like we should use the .do_aux_work interface of
> the PTP clock. This doesn't work because all PFs must cache this time, but
> only one PF owns the PTP clock device.
> 
> Thus, the ice driver will manage its own kthread instead of relying on the PTP
> do_aux_work handler.
> 
> With this change, the driver can now report Rx timestamps on all incoming
> packets.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |   8 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  22 ++
>  drivers/net/ethernet/intel/ice/ice_ptp.c      | 335 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |  28 ++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   3 +
>  9 files changed, 407 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


