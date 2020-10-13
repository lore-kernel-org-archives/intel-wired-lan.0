From: Shen, Yijun <Yijun.Shen@dell.com>
Date: Tue, 13 Oct 2020 16:03:27 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Dell's Comet Lake
 systems into s0ix heuristics
In-Reply-To: <DM6PR19MB263685129F30B4D7213398A9FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
 <20200928044024.7595-3-mario.limonciello@dell.com>
 <DM6PR11MB2890F9ACE2ACF01E52A1ADBDBC0A0@DM6PR11MB2890.namprd11.prod.outlook.com>
 <DM6PR19MB263685129F30B4D7213398A9FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
Message-ID: <DM6PR19MB3691176E50F919E5CE9ED5C79A040@DM6PR19MB3691.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Sent: Wednesday, October 7, 2020 8:30 AM
> To: Brown, Aaron F; Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Yuan, Perry; Shen, Yijun; linux-kernel at vger.kernel.org
> Subject: RE: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Dell's Comet Lake
> systems into s0ix heuristics
> 
> 
> > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > > Of Mario Limonciello
> > > Sent: Sunday, September 27, 2020 9:40 PM
> > > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> > > lan at lists.osuosl.org
> > > Cc: Perry.Yuan at dell.com; Yijun.Shen at dell.com;
> > > linux-kernel at vger.kernel.org; Mario Limonciello
> > > <mario.limonciello@dell.com>
> > > Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Dell's Comet Lake
> > > systems into s0ix heuristics
> > >
> > > Dell's Comet Lake Latitude and Precision systems containing i219LM
> > > are properly configured and should use the s0ix flows.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/net/ethernet/intel/Kconfig        |  1 +
> > >  drivers/net/ethernet/intel/e1000e/param.c | 80
> > > ++++++++++++++++++++++-
> > >  2 files changed, 80 insertions(+), 1 deletion(-)
> >
> > Is there anyone who touched this hardware with this patch willing to
> > provide a Tested-by:?
> > I am happy to do regression / sanity checks against other e1000e based
> > systems, but do not have access to these devices.
> 
> Alex (Yijun) who is CC'ed did test them and I expect can add a Tested-By after
> the China holidays are over.
> 

Tested-by: Yijun Shen <Yijun.shen@dell.com>

> >
> > >
> > > diff --git a/drivers/net/ethernet/intel/Kconfig
> > > b/drivers/net/ethernet/intel/Kconfig
> > > index 5aa86318ed3e..280af47d74d2 100644
> > > --- a/drivers/net/ethernet/intel/Kconfig
> > > +++ b/drivers/net/ethernet/intel/Kconfig
> > > @@ -58,6 +58,7 @@ config E1000
> > >  config E1000E
> > >  	tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
> > >  	depends on PCI && (!SPARC32 || BROKEN)
> > > +	depends on DMI
> > >  	select CRC32
> > >  	imply PTP_1588_CLOCK
> > >  	help
> > > diff --git a/drivers/net/ethernet/intel/e1000e/param.c
> > > b/drivers/net/ethernet/intel/e1000e/param.c
> > > index e66b222c824b..58e6718c4f75 100644
> > > --- a/drivers/net/ethernet/intel/e1000e/param.c
> > > +++ b/drivers/net/ethernet/intel/e1000e/param.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright(c) 1999 - 2018 Intel Corporation. */
> > >
> > > +#include <linux/dmi.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > > @@ -201,6 +202,80 @@ static const struct e1000e_me_supported
> > > me_supported[] = {
> > >  	{0}
> > >  };
> > >
> > > +static const struct dmi_system_id s0ix_supported_systems[] = {
> > > +	{
> > > +		/* Dell Latitude 5310 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "099F"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Latitude 5410 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09A0"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Latitude 5410 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C9"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Latitude 5510 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09A1"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Precision 3550 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09A2"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Latitude 5411 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C0"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Latitude 5511 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C1"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Precision 3551 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C2"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Precision 7550 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C3"),
> > > +		},
> > > +	},
> > > +	{
> > > +		/* Dell Precision 7750 */
> > > +		.matches = {
> > > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +			DMI_MATCH(DMI_PRODUCT_SKU, "09C4"),
> > > +		},
> > > +	},
> > > +	{ }
> > > +};
> > > +
> > >  static bool e1000e_check_me(u16 device_id)  {
> > >  	struct e1000e_me_supported *id;
> > > @@ -599,8 +674,11 @@ void e1000e_check_options(struct
> e1000_adapter
> > > *adapter)
> > >  		}
> > >
> > >  		if (enabled == S0IX_HEURISTICS) {
> > > +			/* check for allowlist of systems */
> > > +			if (dmi_check_system(s0ix_supported_systems))
> > > +				enabled = S0IX_FORCE_ON;
> > >  			/* default to off for ME configurations */
> > > -			if (e1000e_check_me(hw->adapter->pdev->device))
> > > +			else if (e1000e_check_me(hw->adapter->pdev-
> > > >device))
> > >  				enabled = S0IX_FORCE_OFF;
> > >  		}
> > >
> > > --
> > > 2.25.1
> > >
> > > _______________________________________________
> > > Intel-wired-lan mailing list
> > > Intel-wired-lan at osuosl.org
> > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
