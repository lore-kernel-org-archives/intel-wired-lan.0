From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 19:25:24 +0000
Subject: [Intel-wired-lan] [next PATCH S54 04/15] i40e: delete filter
 after	adding its replacement when converting
In-Reply-To: <1478896779-13697-5-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37FE2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 04/15] i40e: delete filter after
> adding its replacement when converting
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix a subtle issue with the code for converting VID=-1 filters into VID=0 filters
> when adding a new VLAN. Previously the code deleted the VID=-1 filter, and
> then added a new VID=0 filter. In the rare case that the addition fails due to -
> ENOMEM, we end up completely deleting the filter which prevents recovery
> if memory pressure subsides. While it is not strictly an issue because it is
> likely that memory issues would result in many other problems, we shouldn't
> delete the filter until after the addition succeeds.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Icba07ddd04ecc6a3b27c2e29f2c1c8673d266826
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


