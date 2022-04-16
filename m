From: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Date: Sat, 16 Apr 2022 17:52:20 +0200
Subject: [Intel-wired-lan] [PATCH v3] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <alpine.DEB.2.22.394.2204161608230.3501@hadrien>
References: <20220416111457.5868-1-eng.alaamohamedsoliman.am@gmail.com>
 <857a2d22-5d0f-99d6-6686-98d50e4491d5@gmail.com>
 <alpine.DEB.2.22.394.2204161608230.3501@hadrien>
Message-ID: <1897617.PYKUYFuaPT@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On sabato 16 aprile 2022 16:09:58 CEST Julia Lawall wrote:
> 
> On Sat, 16 Apr 2022, Alaa Mohamed wrote:
> 
> >
> > On ????/??/??? ???? ????:????, Julia Lawall wrote:
> > >
> > > On Sat, 16 Apr 2022, Alaa Mohamed wrote:
> > >
> > > > Convert kmap() to kmap_local_page()
> > > >
> > > > With kmap_local_page(), the mapping is per thread, CPU local and 
not
> > > > globally visible.
> > > It's not clearer.
> > I mean this " fix kunmap_local path value to take address of the mapped 
page"
> > be more clearer
> > > This is a general statement about the function.  You
> > > need to explain why it is appropriate to use it here.  Unless it is 
the
> > > case that all calls to kmap should be converted to call 
kmap_local_page.
> > It's required to convert all calls kmap to kmap_local_page. So, I don't 
what
> > should the commit message be?
> 
> If all calls should be changed then you can also say that.

If all calls should be changed with no regards to the surrounding contexts 
and special situations, we can just make an automated s/kmap()/
kmap_local_page()/ or something else similar :)

Thanks,

Fabio M. De Francesco

> 
> I thought that a previous commit on the outreachy list made some 
arguments
> about how the affacted value was just allocated and thus could not yet be
> shared.
> 
> julia



