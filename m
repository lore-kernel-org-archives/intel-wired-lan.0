From: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Date: Sat, 16 Apr 2022 18:28:12 +0200
Subject: [Intel-wired-lan] [PATCH v3] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <1897617.PYKUYFuaPT@leap>
References: <20220416111457.5868-1-eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204161608230.3501@hadrien> <1897617.PYKUYFuaPT@leap>
Message-ID: <2114356.Mh6RI2rZIc@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On sabato 16 aprile 2022 17:52:20 CEST Fabio M. De Francesco wrote:
> On sabato 16 aprile 2022 16:09:58 CEST Julia Lawall wrote:
> > 
> > On Sat, 16 Apr 2022, Alaa Mohamed wrote:
> > 
> > >
> > > On ????/??/??? ???? ????:????, Julia Lawall wrote:
> > > >
> > > > On Sat, 16 Apr 2022, Alaa Mohamed wrote:
> > > >
> > > > > Convert kmap() to kmap_local_page()
> > > > >
> > > > > With kmap_local_page(), the mapping is per thread, CPU local and 
> not
> > > > > globally visible.
> > > > It's not clearer.
> > > I mean this " fix kunmap_local path value to take address of the 
mapped 
> page"
> > > be more clearer
> > > > This is a general statement about the function.  You
> > > > need to explain why it is appropriate to use it here.  Unless it is 
> the
> > > > case that all calls to kmap should be converted to call 
> kmap_local_page.
> > > It's required to convert all calls kmap to kmap_local_page. So, I 
don't 
> what
> > > should the commit message be?
> > 
> > If all calls should be changed then you can also say that.
> 
> If all calls should be changed with no regards to the surrounding 
contexts 
> and special situations, we can just make an automated s/kmap()/
> kmap_local_page()/ or something else similar :)

Obviously, I was just kidding because we cannot massively and blindly 
change all kmap() calls to kmap_local_page().

IMO, here the changes in code are good but Julia's objections are 
legitimate too.

Thanks,

Fabio

> > 
> > I thought that a previous commit on the outreachy list made some 
> arguments
> > about how the affacted value was just allocated and thus could not yet 
be
> > shared.
> > 
> > julia
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220416/51c29e10/attachment-0001.html>
