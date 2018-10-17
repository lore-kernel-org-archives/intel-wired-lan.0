From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 18:04:35 +0200
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: fix XFRM_ALGO
 dependency
In-Reply-To: <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
References: <20181016100848.1329843-1-arnd@arndb.de>
 <07e372cb-06da-bf95-bc53-64ee09fc8e76@oracle.com>
 <3f8e7a6e9532abcd772927432d5f00cebeba08b8.camel@intel.com>
Message-ID: <CAK8P3a3RiMHVkoA+Wp_abPJ5Fzwk5UdhoOaxt++q4_YnzDRwfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 17, 2018 at 5:53 PM Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Tue, 2018-10-16 at 09:35 -0700, Shannon Nelson wrote:
> > On 10/16/2018 3:03 AM, Arnd Bergmann wrote:
> > > A separate Kconfig symbol now controls whether we include the ipsec
> > > offload code. To keep the old behavior, this is left as 'default
> > > y'. The
> > > dependency in XFRM_OFFLOAD still causes a circular dependency but
> > > is
> > > not actually needed because this symbol is not user visible, so
> > > removing
> > > that dependency on top makes it all work.
> > >
> > > Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I agree with Shannon's suggested changes.  Arnd, are you working on v2?
> Or would you like me to take care of it?

I was planning to respin it, but didn't get around to it yet, and will
be travelling for the next week, so I'd welcome if you can take over
from here. Shannon's comments all make sense to me as well.

> > > +config IXGBE_IPSEC
> > > +   bool "IPSec XFRM cryptography-offload accelaration"
> > > +   default n
> >
> > remove this "default n" line?

I meant for this to say "default y", as I said in the changelog,
but feel free to pick whichever default makes sense to you
make make the description match ;-)

Thanks,

       Arnd
