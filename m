From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 19:34:02 +0000
Subject: [Intel-wired-lan] [PATCH S12 09/14] ice: Implement flow to
 reset VFs with PFR and other resets
In-Reply-To: <20190208205101.12078-10-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367037@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 09/14] ice: Implement flow to reset VFs
> with PFR and other resets
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> All VF VSIs need to be reset and rebuild with the main VSIs before replaying
> all VSIs, so that all existing switch filters, scheduler tree and other
> configuration could be replayed at once. This fixes issues when doing PFR
> and CORER reset.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


