From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 18:58:27 +0000
Subject: [Intel-wired-lan] [next PATCH S23 05/13] i40e: Replace X722
	mac	check in ethtool get_settings
In-Reply-To: <1449705033-4968-6-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-6-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98018D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 05/13] i40e: Replace X722 mac
> check in ethtool get_settings
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> 100M SGMII is only supported on X722.  Replace the mac check with a
> feature flag check that is only set for the X722 device.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I53452d9af6af8cd9dca8500215fbc6ce93418f52
> ---
> Testing Hints: Check that 100M SGMII is not listed as supported on X710
> devices and is listed as supported on X722 devices.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, does not break base driver
