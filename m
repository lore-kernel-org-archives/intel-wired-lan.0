From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:45:48 +0000
Subject: [Intel-wired-lan] [PATCH S41 09/15] ice: Fix resource leak on
 early exit from function
In-Reply-To: <20200508004113.39725-9-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-9-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16595619396F0EB3DD0A1B968CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S41 09/15] ice: Fix resource leak on early
> exit from function
> 
> From: Eric Joyner <eric.joyner@intel.com>
> 
> Memory allocated in the ice_add_prof_id_vsig() function wasn't being
> properly freed if an error occurred inside the for-loop in the function.
> 
> In particular, 'p' wasn't being freed if an error occurred before it was added
> to the resource list at the end of the for-loop.
> 
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


