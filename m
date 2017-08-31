From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 31 Aug 2017 19:02:10 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 04/13] i40e:
	redfine	I40E_PHY_TYPE_MAX
In-Reply-To: <20170829093242.41026-4-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA94F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 04/13] i40e: redfine
> I40E_PHY_TYPE_MAX
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Since I40E_PHY_TYPE_MAX is used as an iterator, ususally combined with
> some sort of bit-shifting, it should only include actual PHY types and not error
> cases. Move it up in the enum declaration so that loops only iterate across
> valid PHY types.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


