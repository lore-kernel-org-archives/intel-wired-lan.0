From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:47:31 +0000
Subject: [Intel-wired-lan] [PATCH S41 12/15] ice: remove unnecessary
 expression that is always true
In-Reply-To: <20200508004113.39725-12-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-12-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659E02B4C22FC3E69C339D88CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 12/15] ice: remove unnecessary
> expression that is always true
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> The else conditional expression is always true due to the if conditional
> expression; remove it and add a comment to make it obvious still.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


