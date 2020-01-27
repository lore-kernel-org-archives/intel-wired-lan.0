From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:15:58 +0000
Subject: [Intel-wired-lan] [PATCH S38 09/15] ice: Fix and refactor Rx
 queue disable for VFs
In-Reply-To: <20200122152138.41585-9-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-9-anthony.l.nguyen@intel.com>
Message-ID: <f9bb58de468b403cb39f458a5ea390de@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 09/15] ice: Fix and refactor Rx queue
> disable for VFs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when a VF driver sends the PF a request to disable Rx queues we
> will disable them one at a time, even if the VF driver sent us a batch of
> queues to disable. This is causing issues where the Rx queue disable times
> out with LFC enabled. This can be improved by detecting when the VF is
> trying to disable all of its queues.
> 
> Also remove the variable num_qs_ena from the ice_vf structure as it was
> only used to see if there were no Rx and no Tx queues active. Instead add a
> function that checks if both the vf->rxq_ena and vf->txq_ena bitmaps are
> empty.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 36 ++++++++++++++-----
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  1 -
>  2 files changed, 27 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


