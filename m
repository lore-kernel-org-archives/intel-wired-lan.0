From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:13:09 +0000
Subject: [Intel-wired-lan] [PATCH S25 08/12] ice: Introduce a local
 variable for a VSI in the rebuild path
In-Reply-To: <20190725095401.24590-8-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-8-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EACC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 08/12] ice: Introduce a local variable for
> a VSI in the rebuild path
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> When a VSI is accessed inside the ice_for_each_vsi macro in the rebuild path
> (ice_vsi_rebuild_all() and ice_vsi_replay_all()), it is referred to as pf->vsi[i].
> Introduce local variables to improve readability.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


