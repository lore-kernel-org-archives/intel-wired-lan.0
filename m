From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:43:15 +0000
Subject: [Intel-wired-lan] [next PATCH S7 9/9] i40e: Remove unicast log
 when VF is leaving multicast mode.
In-Reply-To: <20190702122259.79070-9-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD2A2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Zagorski, CzeslawX <czeslawx.zagorski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S7 9/9] i40e: Remove unicast log when
> VF is leaving multicast mode.
> 
> From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> 
> This patch removes unicast log when VF is leaving multicast mode.
> Added check of vf->vf_states &
> I40E_VF_STATE_MC_PROMISC/I40E_VF_STATE_UC_PROMISC.
> Without this commit, leaving multicast mode logs "unset unicast"
> in dmsg.
> 
> Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 39 ++++++++++---------
>  1 file changed, 21 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


