From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:03:33 +0000
Subject: [Intel-wired-lan] [PATCH net 4/8] iavf: Fix failure to exit out
 from last all-multicast mode
In-Reply-To: <20210604164900.33156-4-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-4-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224EA6DE28E65C5B9F360F1828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 4/8] iavf: Fix failure to exit out from last
> all-multicast mode
> 
> From: Piotr Marczak <piotr.marczak@intel.com>
> 
> The driver could only quit allmulti when allmulti and promisc modes are turn
> on at the same time. If promisc had been off there was no way to turn off
> allmulti mode.
> The patch corrects this behavior. Switching allmulti does not depends on
> promisc state mode anymore
> 
> Fixes: f42a5c74da99 ("i40e: Add allmulti support for the VF")
> Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


