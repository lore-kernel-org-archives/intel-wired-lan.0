From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 19:23:00 +0000
Subject: [Intel-wired-lan] [next PATCH S16 13/15] i40evf: relax and
 stagger	init timing a bit
In-Reply-To: <1443463964-148204-14-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2CE0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 13/15] i40evf: relax and stagger
> init timing a bit
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> On some devices, in some systems, in some configurations, the VFs would
> fail to initialize the first time you loaded the driver.
> 
> To correct this, increase the delay time for the init task slightly, and wait
> longer before giving up.
> 
> If we enable VFs and load the VF driver in the same kernel as the PF driver,
> we can totally overwhelm the PF driver with AQ requests because all of the
> instances try to initialize at the same time.
> 
> To help alleviate this, stagger the initial scheduling of the init task using the
> PCIe function as a multiplier. We mask off the function to only three bits so
> no instance has to wait too long.
> 
> With these two changes, initializing 128 VFs on a single device goes from four
> minutes to just a few seconds.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: If3d8720c1c4e838ab36d8781d9ec295a62380936
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h      | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, able to initialize and remove 64 VFs in a few seconds.
