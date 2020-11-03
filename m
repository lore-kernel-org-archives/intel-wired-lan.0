From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 03 Nov 2020 15:41:11 -0800
Subject: [Intel-wired-lan] [PATCH v3 0/9] igc: Add XDP support
In-Reply-To: <20201102183129.GM6427@ranger.igk.intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
 <20201102183129.GM6427@ranger.igk.intel.com>
Message-ID: <160444687175.10323.1018795712592451265@anemani-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-11-02 10:31:29)
> On Fri, Oct 30, 2020 at 02:03:42PM -0700, Andre Guedes wrote:
> > Hi all,
> > 
> > This is the third version of this series which adds XDP support to igc driver.
> > 
> > The main changes from v2 are:
> > 
> >     - Moved functions that belong to the driver's hot path to igc_main.c to
> >       allow the compiler to inline them if convenient.
> >     - Squashed ndo_xdp_xmit patch into XDP_REDIRECT patch.
> > 
> > v2 is here:
> > 
> >     https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201028201943.93147-1-andre.guedes at intel.com/
> > 
> > v1 is here:
> > 
> >     https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20201009025349.4037-1-andre.guedes at intel.com/
> > 
> > Cheers,
> > Andre
> 
> I had only minor comments/questions for this version, so you can take my:
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> for series.

Thanks for the review, Maceij! I'm adding your Reviewed-by to the next version
of this series I'm submitting soon.
