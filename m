From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 17:04:11 +0000
Subject: [Intel-wired-lan] [PATCH S28 5/9] ice: update tx context struct
In-Reply-To: <20190827131354.12703-5-anthony.l.nguyen@intel.com>
References: <20190827131354.12703-1-anthony.l.nguyen@intel.com>
 <20190827131354.12703-5-anthony.l.nguyen@intel.com>
Message-ID: <3c03e5b9e30940cda48b9bbe1585d942@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, August 27, 2019 6:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 5/9] ice: update tx context struct
> 
> From: Ashish Shah <ashish.n.shah@intel.com>
> 
> add internal usage flag, bit 91 as described in spec.
> update width of internal queue state to 122 also as described in spec.
> 
> Signed-off-by: Ashish Shah <ashish.n.shah@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c    | 3 ++-
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


