From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:01:30 +0000
Subject: [Intel-wired-lan] [PATCH S8 12/16] ice: Check for q_vector when
 stopping rings
In-Reply-To: <20181026174105.11628-13-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D3A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 12/16] ice: Check for q_vector when
> stopping rings
> 
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> There is a gap in time between a VF reset, which sets the q_vector to NULL,
> and the VF requesting mapping of the q_vectors. If
> ice_vsi_stop_tx_rings() is called during this time, a NULL pointer dereference
> is encountered. Add a check in ice_vsi_stop_tx_rings() to ensure the
> q_vector is set to avoid this situation from occurring.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


