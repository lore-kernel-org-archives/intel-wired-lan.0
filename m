From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:02:32 +0000
Subject: [Intel-wired-lan] [PATCH net 6/8] iavf: validate pointers
In-Reply-To: <20210604164900.33156-6-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-6-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB42240978E3DF93971644762F828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 6/8] iavf: validate pointers
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In some cases, the ethtool get_rxfh handler may be called with a null key or
> indir parameter. So check these pointers, or you will have a very bad day.
> 
> Fixes: 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS")
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


