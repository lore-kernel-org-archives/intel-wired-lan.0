From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:33:24 +0000
Subject: [Intel-wired-lan] [PATCH S18 03/15] ice: Don't remove VLAN
 filters that were never programmed
In-Reply-To: <20190416172128.27184-4-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3998BC@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 03/15] ice: Don't remove VLAN filters
> that were never programmed
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> In case of non-trusted VFs, it is possible to program VLAN filter far less than
> what is requested by the VF originally, thereby makes number of VLAN
> elements being tracked by VF different from actual VLAN tags. This patch
> makes sure that we are not attempting to remove VLAN filter that does not
> exist.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  6 +++++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 +++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


