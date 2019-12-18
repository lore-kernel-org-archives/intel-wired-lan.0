From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:34:06 +0000
Subject: [Intel-wired-lan] [PATCH S35 14/15] ice: Add a boundary check
 in ice_xsk_umem()
In-Reply-To: <20191212111307.33566-14-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-14-anthony.l.nguyen@intel.com>
Message-ID: <124876f72eca48a185bade7ab789c239@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 14/15] ice: Add a boundary check in
> ice_xsk_umem()
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> In ice_xsk_umem(), variable qid which is later used as an array index, is not
> validated for a possible boundary exceedance. Because of that, a calling
> function might receive an invalid address, which causes general protection
> fault when dereferenced.
> 
> To address this, add a boundary check to see if qid is greater than the size of
> a UMEM array. Also, don't let user change vsi->num_xsk_umems just by
> trying to setup a second UMEM if its value is already set up (i.e. UMEM
> region has already been allocated for this VSI).
> 
> While at it, make sure that ring->zca.free pointer is always zeroed out if there
> is no UMEM on a specified ring.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 5 +++--
>  drivers/net/ethernet/intel/ice/ice_base.c | 1 +
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


