From: Julia Lawall <julia.lawall@inria.fr>
Date: Sat, 16 Apr 2022 16:09:58 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v3] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <857a2d22-5d0f-99d6-6686-98d50e4491d5@gmail.com>
References: <20220416111457.5868-1-eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204161331080.3501@hadrien>
 <857a2d22-5d0f-99d6-6686-98d50e4491d5@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204161608230.3501@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Sat, 16 Apr 2022, Alaa Mohamed wrote:

>
> On ??/?/???? ??:??, Julia Lawall wrote:
> >
> > On Sat, 16 Apr 2022, Alaa Mohamed wrote:
> >
> > > Convert kmap() to kmap_local_page()
> > >
> > > With kmap_local_page(), the mapping is per thread, CPU local and not
> > > globally visible.
> > It's not clearer.
> I mean this " fix kunmap_local path value to take address of the mapped page"
> be more clearer
> > This is a general statement about the function.  You
> > need to explain why it is appropriate to use it here.  Unless it is the
> > case that all calls to kmap should be converted to call kmap_local_page.
> It's required to convert all calls kmap to kmap_local_page. So, I don't what
> should the commit message be?

If all calls should be changed then you can also say that.

I thought that a previous commit on the outreachy list made some arguments
about how the affacted value was just allocated and thus could not yet be
shared.

julia

>
> Is this will be good :
>
> "kmap_local_page() was recently developed as a replacement for kmap().? The
> kmap_local_page() creates a mapping which is restricted to local use by a
> single thread of execution. "
> >
> > julia
> >
> > > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > > ---
> > > changes in V2:
> > > 	fix kunmap_local path value to take address of the mapped page.
> > > ---
> > > changes in V3:
> > > 	edit commit message to be clearer
> > > ---
> > >   drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > > b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > > index 2a5782063f4c..c14fc871dd41 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > > @@ -1798,14 +1798,14 @@ static int igb_check_lbtest_frame(struct
> > > igb_rx_buffer *rx_buffer,
> > >
> > >   	frame_size >>= 1;
> > >
> > > -	data = kmap(rx_buffer->page);
> > > +	data = kmap_local_page(rx_buffer->page);
> > >
> > >   	if (data[3] != 0xFF ||
> > >   	    data[frame_size + 10] != 0xBE ||
> > >   	    data[frame_size + 12] != 0xAF)
> > >   		match = false;
> > >
> > > -	kunmap(rx_buffer->page);
> > > +	kunmap_local(data);
> > >
> > >   	return match;
> > >   }
> > > --
> > > 2.35.2
> > >
> > >
> > >
>
