From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 May 2015 02:04:22 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Fix i354 88E1112 PHY on RCC
 boards using AutoMediaDetect
In-Reply-To: <20150429222328.18201.67366.stgit@htfujina-fc.jf.intel.com>
References: <20150429222328.18201.67366.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DCF6E4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Wednesday, April 29, 2015 3:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: Fix i354 88E1112 PHY on RCC boards
> using AutoMediaDetect
> 
> e1000_check_for_link_media_swap() checks PHY page 0 for copper and PHY
> page 1 for "other" (fiber) link. The switch back from page 1 to page 0
> happened too soon, before e1000_check_for_link_82575() is executed, and
> link on fiber (other) was never detected. Check for link while still on
> the proper PHY page.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

