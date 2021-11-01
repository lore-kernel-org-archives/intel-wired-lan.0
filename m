From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:02:59 +0000
Subject: [Intel-wired-lan] [PATCH net 5/8] iavf: prevent accidental free
 of filter structure
In-Reply-To: <20210604164900.33156-5-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-5-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224B5EC0C8143C2437D9434828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 5/8] iavf: prevent accidental free of
> filter structure
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In iavf_config_clsflower, the filter structure could be accidentally released at
> the end, if iavf_parse_cls_flower or iavf_handle_tclass ever return a non-
> zero but positive value.
> 
> In this case, the function continues through to the end, and will call
> kfree() on the filter structure even though it has been added to the linked
> list.
> 
> This can actually happen because iavf_parse_cls_flower will return a positive
> IAVF_ERR_CONFIG value instead of the traditional negative error codes.
> 
> Fix this by ensuring that the kfree() check and error checks are similar. Use
> the more idiomatic "if (err)" to catch all non-zero error codes.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


