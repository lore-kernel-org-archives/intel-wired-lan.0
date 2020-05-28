From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:20:33 +0000
Subject: [Intel-wired-lan] [PATCH S46 8/9] ice: fix aRFS after flow
 director delete
In-Reply-To: <20200516005506.5113-8-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-8-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16598AC5FB266D4C4F918BB28C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 8/9] ice: fix aRFS after flow director
> delete
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The logic was missing for adding back perfect flows after flow director filter
> delete. The code now adds perfect flows into the HW tables after filter
> delete.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


