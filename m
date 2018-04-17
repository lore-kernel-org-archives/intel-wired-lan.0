From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:55:21 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] igb: Fix the transmission
 mode of queue 0 for Qav mode
References: <20180331000652.2855-1-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83B016@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:28 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>; Guedes, Andre
> <andre.guedes@intel.com>
> Subject: RE: [next-queue PATCH] igb: Fix the transmission mode of queue 0
> for Qav mode
> 
> > From: netdev-owner at vger.kernel.org [mailto:netdev-
> > owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> > Sent: Friday, March 30, 2018 5:07 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> > Jesus <jesus.sanchez-palencia@intel.com>; Guedes, Andre
> > <andre.guedes@intel.com>
> > Subject: [next-queue PATCH] igb: Fix the transmission mode of queue 0 for
> > Qav mode
> >
> > When Qav mode is enabled, queue 0 should be kept on Stream
> Reservation
> > mode. From the i210 datasheet, section 8.12.19:
> >
> > "Note: Queue0 QueueMode must be set to 1b when TransmitMode is set
> to
> > Qav." ("QueueMode 1b" represents the Stream Reservation mode)
> >
> > The solution is to give queue 0 the all the credits it might need, so
> > it has priority over queue 1.
> >
> > A situation where this can happen is when cbs is "installed" only on
> > queue 1, leaving queue 0 alone. For example:
> >
> > $ tc qdisc replace dev enp2s0 handle 100: parent root mqprio num_tc 3 \
> >      	   map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0
> >
> > $ tc qdisc replace dev enp2s0 parent 100:2 cbs locredit -1470 \
> >      	   hicredit 30 sendslope -980000 idleslope 20000 offload 1
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
