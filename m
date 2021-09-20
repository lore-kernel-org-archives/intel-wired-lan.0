From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 20 Sep 2021 05:09:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: update dim usage
 and moderation
In-Reply-To: <20210824011259.738307-2-jesse.brandeburg@intel.com>
References: <20210824011259.738307-1-jesse.brandeburg@intel.com>
 <20210824011259.738307-2-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB3367A0D5012BA3D5BC37A058FCA09@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Tuesday, August 24, 2021 6:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: update dim usage and
> moderation
> 
> The driver was having trouble with unreliable latency when doing single
> threaded ping-pong tests. This was root caused to the DIM algorithm landing
> on a too slow interrupt value, which caused high latency, and it was especially
> present when queues were being switched frequently by the scheduler as
> happens on default setups today.
> 
> In attempting to improve this, we allow the upper rate limit for interrupts to
> move to rate limit of 4 microseconds as a max, which means that no vector
> can generate more than 250,000 interrupts per second. The old config was up
> to 100,000. The driver previously tried to program the rate limit too
> frequently and if the receive and transmit side were both active on the same
> vector, the INTRL would be set incorrectly, and this change fixes that issue as
> a side effect of the redesign.
> 
> This driver will operate from now on with a slightly changed DIM table with
> more emphasis towards latency sensitivity by having more table entries with
> lower latency than with high latency (high being >= 64 microseconds).
> 
> The driver also resets the DIM algorithm state with a new stats set when
> there is no work done and the data becomes stale (older than 1 second), for
> the respective receive or transmit portion of the interrupt.
> 
> Add a new helper for setting rate limit, which will be used more in a followup
> patch.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> ---
> v3: merged on top of tx_ring/rx_ring split patch series
> v2: original version
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  25 +++++
>  drivers/net/ethernet/intel/ice/ice_lib.h  |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 118 ++++++++++++----------
> drivers/net/ethernet/intel/ice/ice_txrx.c |  84 ++++++++-------
>  4 files changed, 141 insertions(+), 87 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
