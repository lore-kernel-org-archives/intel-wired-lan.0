From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:01:54 +0000
Subject: [Intel-wired-lan] [PATCH net 8/8] iavf: Fix for setting queues
 to 0
In-Reply-To: <20210604164900.33156-8-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-8-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224E858E9DECBF23423FF46828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 8/8] iavf: Fix for setting queues to 0
> 
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> Now setting combine to 0 will be rejected with the appropriate error code.
> This has been implemented by adding a condition that checks the value of
> combine equal to zero.
> Without this patch, when the user requested it, no error was returned and
> combine was set to the default value for VF.
> 
> Fixes: 5520deb15326 ("iavf: Enable support for up to 16 queues")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


