From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 8 Dec 2020 10:52:28 +0000
Subject: [Intel-wired-lan] [PATCH v4 2/6] igb: take vlan double header
 into account
In-Reply-To: <20201205094213.p64bkcmd3lr4iejl@SvensMacBookAir-2.local>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-3-sven.auhagen@voleatech.de>
 <DM6PR11MB454615FDFC4E7B71D9B82FA29CF40@DM6PR11MB4546.namprd11.prod.outlook.com>
 <20201201095852.2dc1e8f8@carbon>
 <20201205094213.p64bkcmd3lr4iejl@SvensMacBookAir-2.local>
Message-ID: <MW3PR11MB45544E9B9B610CC6553F246B9CCD0@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 01, 2020 at 09:58:52AM +0100, Jesper Dangaard Brouer wrote:
> > On Tue, 1 Dec 2020 08:23:23 +0000
> > "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com> wrote:
> >
> > > Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> >
> > Very happy that you are testing this.
> >
> > Have you also tested that samples/bpf/ xdp_redirect_cpu program works?
> 
> Hi Jesper,
> 
> I have tested the xdp routing example but it would be good if someone can
> double check this.
> 
> Best
> Sven
> 
Hi Jesper, Sven

I have tested xdp_redirect_cpu and it is working.

Thanks,
Sandeep
> >
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn:
> >
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.l
> >
> inkedin.com%2Fin%2Fbrouer&amp;data=04%7C01%7Csven.auhagen%40vol
> eatech.
> >
> de%7C5a78333f75c945b9bcee08d895d75e5b%7Cb82a99f679814a7295344d3
> 5298f84
> >
> 7b%7C0%7C0%7C637424099531073949%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=
> > g80690tGbCHAi3lr412ZlKoxwIFSIzn5e8V8nO1aZcw%3D&amp;reserved=0
> >
