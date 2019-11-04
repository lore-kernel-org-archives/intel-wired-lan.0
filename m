From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Nov 2019 20:17:02 +0000
Subject: [Intel-wired-lan] [PATCH S30 v4 4/9] ice: Move common functions
 to ice_txrx_lib.c
In-Reply-To: <20191031143005.5002-2-anthony.l.nguyen@intel.com>
References: <20191031143005.5002-1-anthony.l.nguyen@intel.com>
 <20191031143005.5002-2-anthony.l.nguyen@intel.com>
Message-ID: <b49d7c99fa83437c98d07103b8183be9@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S30 v4 4/9] ice: Move common functions to
> ice_txrx_lib.c
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> In preparation of AF XDP, move functions that will be used both by skb and
> zero-copy paths to a new file called ice_txrx_lib.c.  This allows us to avoid
> using ifdefs to control the staticness of said functions.
> 
> Move other functions (ice_rx_csum, ice_rx_hash and ice_ptype_to_htype)
> called only by the moved ones to the new file as well.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v4:
> - Change ice_build_ctob() call to build_ctob()
> v2:
> - Move ice_build_ctob() to ice_txrx_lib.h
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 303 +-----------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  10 -
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 273 ++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  59 ++++
>  5 files changed, 334 insertions(+), 312 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx_lib.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


