From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:38:13 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 02/15] ice: update malicious
 driver detection event handling
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <c2937eb7cc0f4156b1eeb6b467be5f32@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 02/15] ice: update malicious driver
> detection event handling
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Update the PF VFs MDD event message to rate limit once per second and
> report the total number Rx|Tx event count. Add support to print pending
> MDD events that occur during the rate limit. The use of net_ratelimit did not
> allow for per VF Rx|Tx granularity.
> 
> Additional PF MDD log messages are guarded by netif_msg_[rx|tx]_err().
> 
> Since VF RX MDD events disable the queue, add ethtool private flag mdd-
> auto-reset-vf to configure VF reset to re-enable the queue.
> 
> Disable anti-spoof detection interrupt to prevent spurious events during a
> function reset.
> 
> To avoid race condition do not make PF MDD register reads conditional on
> global MDD result.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> - Add MAC address to MDD message
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   4 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   1 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 126 ++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  56 +++++++-
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  20 ++-
>  6 files changed, 150 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


