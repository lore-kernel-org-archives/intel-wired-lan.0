From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 16 Sep 2020 23:33:30 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support for Comet Lake
In-Reply-To: <292c4e24-9efb-0057-6d50-2b8c72456215@intel.com>
References: <20191010101539.37043-1-sasha.neftin@intel.com>
 <b97d6390-2226-ef51-d87b-736aa6e7189a@molgen.mpg.de>
 <292c4e24-9efb-0057-6d50-2b8c72456215@intel.com>
Message-ID: <5757947b94e63238c8dfc04288323e8d73f1b58d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-09-15 at 09:48 +0300, Neftin, Sasha wrote:
> On 9/14/2020 10:35, Paul Menzel wrote:
> > Dear Sasha, dear Jeff,
> > 
> > 
> > Am 10.10.19 um 12:15 schrieb Sasha Neftin:
> > > Add devices ID's for the next LOM generations that will be
> > > available on the next Intel Client platform (Comet Lake)
> > > This patch provides the initial support for these devices
> > > 
> > > Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> > > ---

<snip>

> > This landed in Linux 5.5, and we would really like to see it in the
> > 5.4 
> > stable series. As it?s just adding new PCI device codes, this
> > sounds 
> > easily doable.
> > 
> > What is the process of getting it into the stable series? I
> > remember the 
> > net subsystem having a different process than just adding `CC: 
> > stable at vger.kernel.org`, which is too late for this anyway, as
> > it?s 
> > already in Linus? master branch.
> 
> Tony, can you help here?
> (If I recall correctly Greg Kroah-Hartman own the stable version
> domain)

I've made the request see if this can be added to 5.4 stable.

Thanks,
Tony
