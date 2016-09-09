From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 19:50:45 +0000
Subject: [Intel-wired-lan] [next PATCH S45 07/10] i40e: cleanup
	ATR	auto_disable_flags use
In-Reply-To: <1473210312-29592-8-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCA9B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 07/10] i40e: cleanup ATR
> auto_disable_flags use
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Some locations that disable ATR accidentally used the "full" disable by
> disabling the flag in the standard flags field. This incorrectly forces ATR off
> permanently instead of temporarily disabling it. In addition, some code
> locations accidentally set the ATR flag enabled when they only meant to clear
> the auto_disable_flags. This results in ignoring the user's ethtool private flag
> settings.
> 
> Additionally, when disabling ATR via ethtool, we did not perform a flush of
> the FD table. This results in the previously assigned ATR rules still functioning
> which was not expected.
> 
> Cleanup all these areas so that automatic disable uses only the
> auto_disable_flag. Fix the flush code so that we can trigger a flush even
> when we've disabled ATR and SB support, as otherwise the flush doesn't
> work. Fix ethtool setting to actually request a flush. Fix NETIF_F_NTUPLE flag
> to only clear the auto_disable setting and not enable the full feature.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ib2486111f8031bd16943e9308757b276305c03b5
> ---
> Testing-hints:
>   See the marked HSDs for details
> 
> HSD-number: 5645176, 5645175
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 +++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 20 +++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 14 +++++++-------
>  3 files changed, 17 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Bugs no longer present


