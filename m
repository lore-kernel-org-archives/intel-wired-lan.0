From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:26:49 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 5/9] ice: update Tx context
 struct
In-Reply-To: <20190903083108.19593-5-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
 <20190903083108.19593-5-anthony.l.nguyen@intel.com>
Message-ID: <3a807e4312664090bb18deb1946a85fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 5/9] ice: update Tx context struct
> 
> From: Ashish Shah <ashish.n.shah@intel.com>
> 
> Add internal usage flag, bit 91 as described in spec.
> Update width of internal queue state to 122 also as described in spec.
> 
> Signed-off-by: Ashish Shah <ashish.n.shah@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c    | 3 ++-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


