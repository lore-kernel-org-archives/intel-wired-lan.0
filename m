From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Mon, 1 Nov 2021 23:05:10 +0000
Subject: [Intel-wired-lan] [PATCH net 7/8] iavf: Fix for the false
 positive ASQ/ARQ errors while issuing VF reset
In-Reply-To: <20210604164900.33156-7-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
 <20210604164900.33156-7-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB42242191344DA8943E85C521828A9@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net 7/8] iavf: Fix for the false positive
> ASQ/ARQ errors while issuing VF reset
> 
> From: Surabhi Boob <surabhi.boob@intel.com>
> 
> While issuing VF Reset from the guest OS, the VF driver prints logs about
> critical / Overflow error detection. This is not an actual error since the
> VF_MBX_ARQLEN register is set to all FF's for a short period of time and the
> VF would catch the bits set if it was reading the register during that spike of
> time.
> This patch introduces an additional check to ignore this condition since the VF
> is in reset.
> 
> Fixes: 19b73d8efaa4 ("i40evf: Add additional check for reset")
> Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


