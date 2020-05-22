From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:56:28 +0000
Subject: [Intel-wired-lan] [PATCH S43 06/15] ice: Fix bad register reads
In-Reply-To: <20200516003644.4658-6-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-6-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659E398D02690F2AD96A3A38CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 06/15] ice: Fix bad register reads
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> The "ethtool -d" handler reads registers in the ice_regs_dump_list array and
> returns read values back to the userspace.
> 
> The register offsets PFINT0_ITR* are not valid as per the specification and
> reading these causes a "unable to handle kernel paging request" bug in the
> driver. Remove these registers from ice_regs_dump_list.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c    | 3 ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 3 ---
>  2 files changed, 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


