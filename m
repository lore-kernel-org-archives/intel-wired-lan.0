From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:04:44 +0000
Subject: [Intel-wired-lan] [PATCH net 1/8] iavf: check for null in
 iavf_fix_features
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224AE047F06DB5D3D4A6D11828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 1/8] iavf: check for null in
> iavf_fix_features
> 
> From: Nicholas Nunley <nicholas.d.nunley@intel.com>
> 
> If the driver has lost contact with the PF then it enters a disabled state and
> frees adapter->vf_res. However, ndo_fix_features can still be called on the
> interface, so we need to check for this condition first. Since we have no
> information on the features at this time simply leave them unmodified and
> return.
> 
> Fixes: c4445aedfe09 ("i40evf: Fix VLAN features")
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


