From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Nov 2019 23:55:50 +0000
Subject: [Intel-wired-lan] [PATCH S30 v4 5/9] ice: Add support for AF_XDP
In-Reply-To: <20191031143005.5002-3-anthony.l.nguyen@intel.com>
References: <20191031143005.5002-1-anthony.l.nguyen@intel.com>
 <20191031143005.5002-3-anthony.l.nguyen@intel.com>
Message-ID: <53a92f5a89ce4e219650d698559267db@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, October 31, 2019 7:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 v4 5/9] ice: Add support for AF_XDP
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> Add zero copy AF_XDP support.  This patch adds zero copy support for Tx and
> Rx; code for zero copy is added to ice_xsk.h and ice_xsk.c.
> 
> For Tx, implement ndo_xsk_wakeup. As with other drivers, reuse existing
> XDP Tx queues for this task, since XDP_REDIRECT guarantees mutual
> exclusion between different NAPI contexts based on CPU ID. In turn, a
> netdev can XDP_REDIRECT to another netdev with a different NAPI context,
> since the operation is bound to a specific core and each core has its own
> hardware ring.
> 
> For Rx, allocate frames as MEM_TYPE_ZERO_COPY on queues that AF_XDP is
> enabled.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v4:
> - Change ice_build_ctob() call to build_ctob()
> v3:
> - Remove unused prototype ice_xsk_umem_query()
> ---
>  drivers/net/ethernet/intel/ice/Makefile      |    1 +
>  drivers/net/ethernet/intel/ice/ice.h         |   26 +
>  drivers/net/ethernet/intel/ice/ice_base.c    |   53 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |    7 +
>  drivers/net/ethernet/intel/ice/ice_lib.c     |   57 +-
>  drivers/net/ethernet/intel/ice/ice_lib.h     |    4 +
>  drivers/net/ethernet/intel/ice/ice_main.c    |   16 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c    |   46 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |   20 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c     | 1181 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_xsk.h     |   72 ++
>  11 files changed, 1456 insertions(+), 27 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_xsk.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_xsk.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


