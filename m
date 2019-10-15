From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:14:51 +0000
Subject: [Intel-wired-lan] [PATCH S30 4/9] ice: Move common functions to
 ice_txrx_lib.c
In-Reply-To: <20191009140925.13997-4-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
 <20191009140925.13997-4-anthony.l.nguyen@intel.com>
Message-ID: <f79efa8d30114ae5842a3b7b0b708a4c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 4/9] ice: Move common functions to
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
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 303 +-----------------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 273 ++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  49 +++
>  4 files changed, 324 insertions(+), 302 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_txrx_lib.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


