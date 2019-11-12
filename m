From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:31:24 +0000
Subject: [Intel-wired-lan] [PATCH S33 03/15] ice: Disallow VF VLAN
 opcodes if VLAN offloads disabled
In-Reply-To: <20191108142331.10221-3-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-3-anthony.l.nguyen@intel.com>
Message-ID: <b115815464814638954b2356983dd029@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 03/15] ice: Disallow VF VLAN opcodes if
> VLAN offloads disabled
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the host disables VLAN offloads on the VF by not setting the
> VIRTCHNL_VF_OFFLOAD_VLAN capability bit we will still honor VF VLAN
> configuration messages over VIRTCHNL. These messages (i.e. enable/disable
> VLAN stripping and VLAN filtering) should be blocked when the feature is not
> supported. Fix that by adding a helper function to determine if the VF is
> allowed to do VLAN operations based on the host's VF configuration.
> 
> Also, mirror the VF communicated capabilities in the host's VF configuration.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


