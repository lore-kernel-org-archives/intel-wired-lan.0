From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Nov 2017 22:25:02 +0000
Subject: [Intel-wired-lan] [next PATCH S82-V4 9/9] i40e: restore
 promiscuous after reset
In-Reply-To: <20171114120052.86665-9-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
 <20171114120052.86665-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAEEFC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, November 14, 2017 4:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S82-V4 9/9] i40e: restore promiscuous
> after reset
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> After a reset we rebuild the VSIs which is going to clobber any promiscuous
> settings we had before reset.  This makes it so that we restore the
> promiscuous settings we had before reset.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
> Testing-hints:
> Set promiscuous mode, force a reset (ethtool -K <iface> ntuple off/on
> should work), check if promiscuous traffic is still received after reset.
> 
> v2:
> - Fix whitespace on i40e_aq_str lines
> - Add error message if i40e_set_promiscuous fails after reset
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 155 +++++++++++++++-------
> ------
>  1 file changed, 83 insertions(+), 72 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


