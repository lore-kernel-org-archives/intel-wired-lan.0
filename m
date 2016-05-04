From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:42:57 +0000
Subject: [Intel-wired-lan] [next PATCH S36 10/12] i40e/i40evf:
	properly	report rx packet hash
In-Reply-To: <1462313600-3123-11-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D59E6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 10/12] i40e/i40evf: properly
> report rx packet hash
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> This logic is inverted. If the RXHASH flag is set, then we should go ahead and
> call skb_set_hash.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib2e30356dced1d3e939c8061ab6ad5bd94197e7c
> ---
> Testing Hints : Not sure how to test this without instrumenting the driver.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Compiles and applies cleanly
