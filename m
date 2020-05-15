From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:43:58 +0000
Subject: [Intel-wired-lan] [PATCH S41 05/15] ice: Fix probe/open race
 condition
In-Reply-To: <20200508004113.39725-5-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-5-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB165996BB95DBBFFB931A584E8CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S41 05/15] ice: Fix probe/open race
> condition
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> As soon as the driver registers the PF netdev, userspace utilities like
> NetworkManager try to bring up the associated interface. When this
> happens, the driver may not have finished initializing fully, resulting in a
> bunch of errors in the interface up flow.
> 
> The driver already has a mechanism to indicate if it's not up yet; by setting
> the __ICE_DOWN bit in pf->state, but this bit gets cleared too early in the
> current flow. So clear this bit only when the driver is fully up. Also check for
> the same bit in the ice_open flow, and return -EBUSY if the bit is set.
> 
> Also in ice_open, replace references of vsi->back with a local variable.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


