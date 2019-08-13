From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:24:52 +0000
Subject: [Intel-wired-lan] [PATCH S27 11/15] ice: Check root pointer for
 validity
In-Reply-To: <20190808143938.4968-11-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-11-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D41168B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 11/15] ice: Check root pointer for
> validity
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> ice_sched_get_tc_node uses pi->root without checking for NULL. Add a
> check to prevent NULL pointer dereference.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


