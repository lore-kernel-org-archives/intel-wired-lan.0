From: Shen, Yijun <Yijun.Shen@dell.com>
Date: Wed, 21 Oct 2020 14:49:31 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Add more Dell CML systems
 into s0ix heuristics
In-Reply-To: <DM6PR11MB2890D867948806FF79EC94E0BC0A0@DM6PR11MB2890.namprd11.prod.outlook.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
 <20200928044024.7595-4-mario.limonciello@dell.com>
 <DM6PR11MB2890D867948806FF79EC94E0BC0A0@DM6PR11MB2890.namprd11.prod.outlook.com>
Message-ID: <SJ0PR19MB4463C698A4DCCD10600A25859A1C0@SJ0PR19MB4463.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Brown, Aaron F <aaron.f.brown@intel.com>
> Sent: Wednesday, October 7, 2020 8:22 AM
> To: Limonciello, Mario; Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Yuan, Perry; Shen, Yijun; linux-kernel at vger.kernel.org
> Subject: RE: [Intel-wired-lan] [PATCH 3/3] e1000e: Add more Dell CML
> systems into s0ix heuristics
> 
> 
> [EXTERNAL EMAIL]
> 
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Mario Limonciello
> > Sent: Sunday, September 27, 2020 9:40 PM
> > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> > lan at lists.osuosl.org
> > Cc: Perry.Yuan at dell.com; Yijun.Shen at dell.com; linux-
> > kernel at vger.kernel.org; Mario Limonciello <mario.limonciello@dell.com>
> > Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Add more Dell CML
> > systems into s0ix heuristics
> >
> > These comet lake systems are not yet released, but have been validated
> > on pre-release hardware.
> 
> Same basic question as with 2/3 of the series, would it be possible to get
> someone who touched / validated the code on the pre-release hardware to
> provide a Tested-by: to this patch?

 Verified this series patches with Dell Systems.

Tested-by: Yijun Shen <Yijun.shen@dell.com>

> 
> >
> > This is being submitted separately from released hardware in case of a
> > regression between pre-release and release hardware so this commit can
> > be reverted alone.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/param.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/param.c
> > b/drivers/net/ethernet/intel/e1000e/param.c
> > index 58e6718c4f75..fe3157c8aa4a 100644
> > --- a/drivers/net/ethernet/intel/e1000e/param.c
> > +++ b/drivers/net/ethernet/intel/e1000e/param.c
> > @@ -273,6 +273,27 @@ static const struct dmi_system_id
> > s0ix_supported_systems[] = {
> >  			DMI_MATCH(DMI_PRODUCT_SKU, "09C4"),
> >  		},
> >  	},
> > +	{
> > +		/* Dell Notebook 0x0A40 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_SKU, "0A40"),
> > +		},
> > +	},
> > +	{
> > +		/* Dell Notebook 0x0A41 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_SKU, "0A41"),
> > +		},
> > +	},
> > +	{
> > +		/* Dell Notebook 0x0A42 */
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_SKU, "0A42"),
> > +		},
> > +	},
> >  	{ }
> >  };
> >
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
