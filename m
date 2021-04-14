From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 14 Apr 2021 23:19:21 +0000
Subject: [Intel-wired-lan] [PATCH S58 02/13] ice: replace custom AIM
 algorithm with kernel's DIM library
In-Reply-To: <20210331211708.55205-2-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
 <20210331211708.55205-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105560AE1E2179BD0765CE4FA4E9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, March 31, 2021 2:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S58 02/13] ice: replace custom AIM
> algorithm with kernel's DIM library
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice driver has support for adaptive interrupt moderation, an algorithm
> for tuning the interrupt rate dynamically. This algorithm is based on various
> assumptions about ring size, socket buffer size, link speed, SKB overhead,
> ethernet frame overhead and more.
> 
> The Linux kernel has support for a dynamic interrupt moderation algorithm
> known as "dimlib". Replace the custom driver-specific implementation of
> dynamic interrupt moderation with the kernel's algorithm.
> 
> The Intel hardware has a different hardware implementation than the
> originators of the dimlib code had to work with, which requires the driver to
> use a slightly different set of inputs for the actual moderation values, while
> getting all the advice from dimlib of better/worse, shift left or right.
> 
> The change made for this implementation is to use a pair of values for each
> of the 5 "slots" that the dimlib moderation expects, and the driver will
> program those pairs when dimlib recommends a slot to use. The currently
> implementation uses two tables, one for receive and one for transmit, and
> the pairs of values in each slot set the maximum delay of an interrupt and a
> maximum number of interrupts per second (both expressed in
> microseconds).
> 
> There are two separate kinds of bugs fixed by using DIMLIB, one is UDP
> single stream send was too slow, and the other is that 8K ping-pong was
> going to the most aggressive moderation and has much too high latency.
> 
> The overall result of using DIMLIB is that we meet or exceed our
> performance expectations set based on the old algorithm.
> 
> Co-developed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig           |   1 +
>  drivers/net/ethernet/intel/ice/ice.h         |   5 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |   6 +
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  13 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 108 +++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 303 +++----------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |   6 +-
>  7 files changed, 175 insertions(+), 267 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


