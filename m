From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 8 Dec 2020 12:39:01 +0100
Subject: [Intel-wired-lan] [PATCH v4 2/6] igb: take vlan double header
 into account
In-Reply-To: <MW3PR11MB45544E9B9B610CC6553F246B9CCD0@MW3PR11MB4554.namprd11.prod.outlook.com>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-3-sven.auhagen@voleatech.de>
 <DM6PR11MB454615FDFC4E7B71D9B82FA29CF40@DM6PR11MB4546.namprd11.prod.outlook.com>
 <20201201095852.2dc1e8f8@carbon>
 <20201205094213.p64bkcmd3lr4iejl@SvensMacBookAir-2.local>
 <MW3PR11MB45544E9B9B610CC6553F246B9CCD0@MW3PR11MB4554.namprd11.prod.outlook.com>
Message-ID: <20201208123901.20e87ee5@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Dec 2020 10:52:28 +0000
"Penigalapati, Sandeep" <sandeep.penigalapati@intel.com> wrote:

> On Tue, Dec 01, 2020 at 09:58:52AM +0100, Jesper Dangaard Brouer wrote:
> > > On Tue, 1 Dec 2020 08:23:23 +0000
> > > "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com> wrote:
> > >  
> > > > Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>  
> > >
> > > Very happy that you are testing this.
> > >
> > > Have you also tested that samples/bpf/ xdp_redirect_cpu program works?  
> > 
> > Hi Jesper,
> > 
> > I have tested the xdp routing example but it would be good if someone can
> > double check this.
> > 
> Hi Jesper, Sven
> 
> I have tested xdp_redirect_cpu and it is working.

Thanks this is great to hear.

You have tested with large frames right?  As cpumap just creates SKBs
based on xdp_frame, and send them to the normal network stack (on
remote CPU), you can just to a standard TCP-stream throughput test with
iperf or netperf.  That should hopefully blowup if we screwed up the
boundaries of the two packets sharing the same page.  (In principle we
should verify the content of the TCP transfer, so maybe a scp + md5sum
is a better test).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

