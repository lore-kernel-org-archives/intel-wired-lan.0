From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:20:00 +0000
Subject: [Intel-wired-lan] [PATCH S35 05/15] ice: Set default value for
 ITR in alloc function
In-Reply-To: <20191212111307.33566-5-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-5-anthony.l.nguyen@intel.com>
Message-ID: <2d6d83cf878d477ba899996cd99b3258@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S35 05/15] ice: Set default value for ITR in
> alloc function
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> When the user sets itr_setting to zero from ethtool -C, the driver changes
> this value to default in ice_cfg_itr (for example after changing ring param).
> Remove code that sets default value in ice_cfg_itr and move it to place
> where the driver allocates q_vectors.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


