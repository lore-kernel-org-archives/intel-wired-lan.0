From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jun 2016 15:53:24 +0000
Subject: [Intel-wired-lan] [next PTACH S38-v2 1/7] i40e: Fix to show
 correct	Advertised Link Modes when link is down
In-Reply-To: <1466439039-16378-2-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
 <1466439039-16378-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E8E90@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, June 20, 2016 9:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PTACH S38-v2 1/7] i40e: Fix to show correct
> Advertised Link Modes when link is down
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> When link is down, Advertised Link Modes was wrongly displaying full
> supported link modes instead of Advertised link mode. Added conditional
> checks in order to make sure correct Advertised link modes are displayed
> when the link is down.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: I8a61413f9ee174149c7a33157b5f0b0a8da9842d
> ---
> Testing Hints: See HSD
> HSD-number: 7660092
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 47 +++++++++++++++-----
> ------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Shows correct advertised link modes regardless of link state
