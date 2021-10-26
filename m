From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 26 Oct 2021 16:21:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 0/4] ice: transmit
 improvement series
In-Reply-To: <20211026000826.156803-1-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
Message-ID: <7afd99cc66d66f81ce68e9bd9e9cc116cefab1eb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-10-25 at 17:08 -0700, Jesse Brandeburg wrote:
> Modify the ice driver to make a few modest changes to the transmit
> hot path in order to reduce the number of cycles used, particularly
> with high intensity workloads such as pktgen or IP forwarding.
> 
> Several of these changes are just using simpler API calls in
> netdevice.h (welcome to 2015!)
> 
> The VSI_DOWN patch is a simple fix to make sure the driver's
> statements
> about holding certain state bits for functions is enforced and
> remains
> that way.
> 
> Jesse Brandeburg (4):
> ? ice: update to newer kernel API
> ? ice: use prefetch methods
> ? ice: tighter control over VSI_DOWN state
> ? ice: use modern kernel API for kick

It looks like patch 2 never made it to the list [1]. Seems like the
email issues may be further reaching than kernel.org.

Thanks,
Tony

[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/list/?series=268871

> ?drivers/net/ethernet/intel/ice/ice_ethtool.c |? 6 ++-
> ?drivers/net/ethernet/intel/ice/ice_main.c??? |? 7 ++--
> ?drivers/net/ethernet/intel/ice/ice_txrx.c??? | 40 +++++++++++++-----
> --
> ?3 files changed, 34 insertions(+), 19 deletions(-)
> 

