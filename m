From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Mon, 13 Apr 2020 07:21:35 -0700
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Remove mac_table from
 igc_adapter
In-Reply-To: <c15d5749-cbc0-6602-72fb-574c635693ac@intel.com>
References: <20200411002834.13916-1-andre.guedes@intel.com>
 <20200411002834.13916-3-andre.guedes@intel.com>
 <c15d5749-cbc0-6602-72fb-574c635693ac@intel.com>
Message-ID: <158678769505.32076.16137849283842601925@ksmartin-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> > index 1127ef81e374..e190a7f83c3c 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> > +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> > @@ -62,6 +62,7 @@
> >    * (RAR[15]) for our directed address used by controllers with
> >    * manageability enabled, allowing us room for 15 multicast addresses.
> >    */
> > +#define IGC_RAH_RAH_MASK     0x0000FFFF
> Hello Andre, does it intentioanlly twice _RAH_RAH_?

Yes. The field name in the datasheet is also 'RAH'. So we have one for the
register name and one for the field name.

- Andre
