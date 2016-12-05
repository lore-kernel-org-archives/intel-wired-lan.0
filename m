From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Dec 2016 21:38:58 +0000
Subject: [Intel-wired-lan] [next PATCH S56 7/8] i40e: Save more
	link	abilities when using ethtool
In-Reply-To: <1480710782-9195-8-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA3942A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S56 7/8] i40e: Save more link abilities
> when using ethtool
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Ethtool support needs to save more PHY information. The added information
> includes FEC capabilities and 25G link types. Without this change it is possible
> to lose 25G or FEC settings by using ethtool.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: Ie42255b1e901ffbf9583b8c46466a54894114280
> ---
> Testing Hints: Found by code inspection. Test by changing link speed from
> 25G to 10G and back to 25G using ethtool.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


