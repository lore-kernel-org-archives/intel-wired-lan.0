From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:13:51 +0000
Subject: [Intel-wired-lan] [PATCH S30 2/9] ice: get rid of per-tc flow
 in Tx queue configuration routines
In-Reply-To: <20191009140925.13997-2-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
 <20191009140925.13997-2-anthony.l.nguyen@intel.com>
Message-ID: <e0e13d50986140a0a4a5993a2b3c3d6c@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S30 2/9] ice: get rid of per-tc flow in Tx
> queue configuration routines
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> There's no reason for treating DCB as first class citizen when configuring the
> Tx queues and going through TCs. Reverse the logic and base the
> configuration logic on rings, which is the object of interest anyway.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 29 +++++++++--
> drivers/net/ethernet/intel/ice/ice_base.h |  4 +-
> drivers/net/ethernet/intel/ice/ice_lib.c  | 63 ++++++++---------------
>  3 files changed, 47 insertions(+), 49 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


