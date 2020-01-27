From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 22:55:43 +0000
Subject: [Intel-wired-lan] [PATCH S38 03/15] ice: Add helper to
 determine if VF link is up
In-Reply-To: <20200122152138.41585-3-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-3-anthony.l.nguyen@intel.com>
Message-ID: <ff111f5a38764be589da099058bc816f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 03/15] ice: Add helper to determine if
> VF link is up
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> The check for vf->link_up is incorrect because this field is only valid if
> vf->link_forced is true. Fix this by adding the helper
> vf->ice_is_vf_link_up()
> to determine if the VF's link is up.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 42 +++++++++++--------
>  1 file changed, 25 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
