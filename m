From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 20:08:38 +0000
Subject: [Intel-wired-lan] [PATCH S43 13/15] ice: Fix memory leak
In-Reply-To: <20200516003644.4658-13-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-13-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659A5A1CD980ED920B0307C8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S43 13/15] ice: Fix memory leak
> 
> From: Surabhi Boob <surabhi.boob@intel.com>
> 
> Handle memory leak on filter management initialization failure.
> 
> Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


