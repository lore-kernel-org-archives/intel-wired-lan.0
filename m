From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 17 Apr 2018 00:55:01 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v7 10/10] igb: Add support
 for adding offloaded clsflower filters
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
 <20180410174959.18757-11-vinicius.gomes@intel.com> 
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C83AFFA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Brown, Aaron F
> Sent: Friday, April 13, 2018 7:25 PM
> To: 'Vinicius Costa Gomes' <vinicius.gomes@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> Jesus <jesus.sanchez-palencia@intel.com>
> Subject: RE: [next-queue PATCH v7 10/10] igb: Add support for adding
> offloaded clsflower filters
> 
> > From: netdev-owner at vger.kernel.org [mailto:netdev-
> > owner at vger.kernel.org] On Behalf Of Vinicius Costa Gomes
> > Sent: Tuesday, April 10, 2018 10:50 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Gomes, Vinicius <vinicius.gomes@intel.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; netdev at vger.kernel.org; Sanchez-Palencia,
> > Jesus <jesus.sanchez-palencia@intel.com>
> > Subject: [next-queue PATCH v7 10/10] igb: Add support for adding
> offloaded
> > clsflower filters
> >
> > This allows filters added by tc-flower and specifying MAC addresses,
> > Ethernet types, and the VLAN priority field, to be offloaded to the
> > controller.
> >
> > This reuses most of the infrastructure used by ethtool, but clsflower
> > filters are kept in a separated list, so they are invisible to
> > ethtool.
> >
> > To setup clsflower offloading:
> >
> > $ tc qdisc replace dev eth0 handle 100: parent root mqprio \
> >      	   	   num_tc 3 map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
> > 		   queues 1 at 0 1 at 1 2 at 2 hw 0
> > (clsflower offloading depends on the netword driver to be configured
> > with multiple traffic classes, we use mqprio's 'num_tc' parameter to
> > set it to 3)
> >
> > $ tc qdisc add dev eth0 ingress
> >
> > Examples of filters:
> >
> > $ tc filter add dev eth0 parent ffff: flower \
> >      	    dst_mac aa:aa:aa:aa:aa:aa \
> > 	    hw_tc 2 skip_sw
> > (just a simple filter filtering for the destination MAC address and
> > steering that traffic to queue 2)
> >
> > $ tc filter add dev enp2s0 parent ffff: proto 0x22f0 flower \
> >      	    src_mac cc:cc:cc:cc:cc:cc \
> > 	    hw_tc 1 skip_sw
> > (as the i210 doesn't support steering traffic based on the source
> > address alone, we need to use another steering traffic, in this case
> > we are using the ethernet type (0x22f0) to steer traffic to queue 1)
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb.h      |   2 +
> >  drivers/net/ethernet/intel/igb/igb_main.c | 188
> > +++++++++++++++++++++-
> >  2 files changed, 188 insertions(+), 2 deletions(-)
> 
> Tested by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
