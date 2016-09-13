From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 18:13:51 +0000
Subject: [Intel-wired-lan] [next PATCH S46 4/8] i40e/i40evf: Add
 txring_txq	function to match fm10k and ixgbe
In-Reply-To: <1473715124-31296-5-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FD0C7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 4/8] i40e/i40evf: Add txring_txq
> function to match fm10k and ixgbe
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds a txring_txq function which allows us to convert a
> i40e_ring/i40evf_ring to a netdev_tx_queue structure.  This way we can
> avoid having to make a multi-line function call for all the spots that need
> access to this.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ic063b71d8b92ea406d2c32e798c8e2b02809d65b
> ---
> Testing Hints:
>         This functionality is most heavily used to stop/start the Tx queues
>         so a good way to exercise this is to push the device with multiple
>         large flows to the point that you start seeing the Tx restart stat
>         incrementing.  As long as no data corruption is reported it is
>         passing.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 17 ++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  9 +++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 17 ++++++-----------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  9 +++++++++
>  4 files changed, 30 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


