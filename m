From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:53:24 +0000
Subject: [Intel-wired-lan] [next PATCH S37 10/15] i40e: Removing
 unnecessary	code which caused supported link mode bug
In-Reply-To: <1463419605-30746-11-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D68DC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 10/15] i40e: Removing
> unnecessary code which caused supported link mode bug
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Removing this code which wasn't allowing 100BaseT to show up in the
> supported link modes for 10GBaseT PHYs.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: Iada2eafa7ef6b4bac9a2a1380ff533ae5de51e1d
> ---
> Testing Hints: Use 'ethtool ethx' check if 100BaseT is listed as one of the
> supported link modes.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
100BaseT shown as supported link mode on 10GBaseT PHY
