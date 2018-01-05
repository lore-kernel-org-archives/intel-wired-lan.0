From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:32:49 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 14/14] i40e/i40evf: Add
 support for new mechanism of updating adaptive ITR
In-Reply-To: <20171229135219.14787-1-alice.michael@intel.com>
References: <20171229135219.14787-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7297@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:52 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 14/14] i40e/i40evf: Add
> support for new mechanism of updating adaptive ITR
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch replaces the existing mechanism for determining the correct value
> to program for adaptive ITR with yet another new and more complicated
> approach.
> 
> The basic idea from a 30K foot view is that this new approach will push the Rx
> interrupt moderation up so that by default it starts in low latency and is
> gradually pushed up into a higher latency setup as long as doing so increases
> the number of packets processed, if the number of packets drops to 4 to 1
> per packet we will reset and just base our ITR on the size of the packets
> being received. For Tx we leave it floating at a high interrupt delay and do not
> pull it down unless we start processing more than 112 packets per interrupt.
> If we start exceeding that we will cut our interrupt rates in half until we are
> back below 112.
> 
> The side effect of these patches are that we will be processing more packets
> per interrupt. This is both a good and a bad thing as it means we will not be
> blocking processing in the case of things like pktgen and XDP, but we will also
> be consuming a bit more CPU in the cases of things such as network
> throughput tests using netperf.
> 
> One delta from this versus the ixgbe version of the changes is that I have
> made the interrupt moderation a bit more aggressive when we are in bulk
> mode by moving our "goldilocks zone" up from 48 to 96 to 56 to 112. The
> main motivation behind moving this is to address the fact that we need to
> update less frequently, and have more fine grained control due to the
> separate Tx and Rx ITR times.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h          |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  15 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 362 ++++++++++++++++----
> ----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     |  17 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 362 ++++++++++++++++---
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   |  17 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |   3 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   6 +-
>  8 files changed, 528 insertions(+), 257 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


