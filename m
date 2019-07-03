From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:18:38 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 11/15] ice: Reduce wait times
 during VF bringup/reset
In-Reply-To: <20190628150332.59155-11-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-11-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD183@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 11/15] ice: Reduce wait times during
> VF bringup/reset
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently there are a couple places where the VF is waiting too long when
> checking the status of registers. This is causing the AVF driver to spin for
> longer than necessary in the __IAVF_STARTUP state. Sometimes it causes
> the AVF to go into the __IAVF_COMM_FAILED, which may retrigger the
> __IAVF_STARTUP state. Try to reduce the chance of this happening by
> removing unnecessary wait times in VF bringup/resets.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 26 +++++++++++--------
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  4 +++
>  2 files changed, 19 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


