From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:03:00 +0000
Subject: [Intel-wired-lan] [PATCH S8 15/16] ice: Avoid nested RTNL
 locking in ice_dis_vsi
In-Reply-To: <20181026174105.11628-16-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328D6B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 15/16] ice: Avoid nested RTNL locking in
> ice_dis_vsi
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> ice_dis_vsi() performs an rtnl_lock() if it detects a netdev that is running on
> the VSI. In cases where the RTNL lock has already been acquired, a deadlock
> results. Add a boolean to pass to ice_dis_vsi to tell it if the RTNL lock is
> already held.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


