From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:03:55 +0000
Subject: [Intel-wired-lan] [PATCH net 3/8] iavf: don't clear a lock we
 don't hold
In-Reply-To: <20210604164900.33156-3-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-3-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB422462EF667A42A541F8F394828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, June 4, 2021 9:49 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 3/8] iavf: don't clear a lock we don't
> hold
> 
> From: Nicholas Nunley <nicholas.d.nunley@intel.com>
> 
> In iavf_configure_clsflower() the function will bail out if it is unable to obtain
> the crit_section lock in a reasonable time. However, it will clear the lock when
> exiting, so fix this.
> 
> Fixes: 640a8af5841f ("i40evf: Reorder configure_clsflower to avoid deadlock
> on error")
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


