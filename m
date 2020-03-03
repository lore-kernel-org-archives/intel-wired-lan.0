From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:09:48 +0000
Subject: [Intel-wired-lan] [PATCH S40 13/15] ice: Use EOPNOTSUPP instead
 of ENOTSUPP
In-Reply-To: <20200227181505.61720-13-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-13-anthony.l.nguyen@intel.com>
Message-ID: <8042ef5ca18e411896b7d5ac7908ffbf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 13/15] ice: Use EOPNOTSUPP instead
> of ENOTSUPP
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Using ENOTSUPP almost always results in some bizarre error message to be
> printed in userspace. This is likely because ENOTSUPP was defined for the
> NFS protocol (as per a comment in include/linux/errno.h). Use EOPNOTSUPP
> instead.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.h         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


