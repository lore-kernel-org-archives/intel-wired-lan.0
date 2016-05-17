From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 19:40:04 +0000
Subject: [Intel-wired-lan] [next PATCH S37 13/15] i40e: set default
	VSI	without a reset
In-Reply-To: <1463419605-30746-14-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-14-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D69FF@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S37 13/15] i40e: set default VSI
> without a reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Remove the need for a reset when the device enters limited promiscuous
> mode. This was causing heartburn for people who were using VFs and
> bridging, since this would require all of the VFs to undergo a reset each time
> the PF changed its promiscuity.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0a83495c5e4d68112bbc7a7a076d20fa8dd3b61c
> ---
> Testing Hints : Make sure default (limited) promiscuous mode works
> correctly with bridging, and that no resets happen when entering and leaving
> promiscuous mode.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 26
> ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Bridges and entering/leaving promiscuous mode works correctly and does not trigger a reset
