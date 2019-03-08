From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:35:40 +0000
Subject: [Intel-wired-lan] [PATCH S17 13/17] ice: Add reg_idx variable
 in ice_q_vector structure
In-Reply-To: <20190228232603.32156-14-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368EF9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 13/17] ice: Add reg_idx variable in
> ice_q_vector structure
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Every time we want to re-enable interrupts and/or write to a register that
> requires an interrupt vector's hardware index we do the following:
> 
> vsi->hw_base_vector + q_vector->v_idx
> 
> This is a wasteful operation, especially in the hot path. Fix this by adding a u16
> reg_idx member to the ice_q_vector structure and make the necessary
> changes to make this work.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  3 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 84
> ++++++++++++++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_main.c | 13 +++--
> drivers/net/ethernet/intel/ice/ice_txrx.c |  2 +-
>  4 files changed, 76 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


