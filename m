From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 11 Feb 2021 17:26:03 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <87czx7r0w8.fsf@toke.dk>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
 <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
 <d5be0627-6a11-9c1f-8507-cc1a1421dade@gmail.com>
 <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
 <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
 <87h7mvsr0e.fsf@toke.dk>
 <CAAOQfrHA+-BsikeQzXYcK_32BZMbm54x5p5YhAiBj==uaZvG1w@mail.gmail.com>
 <87bld2smi9.fsf@toke.dk>
 <20210202113456.30cfe21e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAAOQfrGqcsn3wu5oxzHYxtE8iK3=gFdTka5HSh5Fe9Hc6HWRWA@mail.gmail.com>
 <20210203090232.4a259958@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <874kikry66.fsf@toke.dk>
 <20210210103135.38921f85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87czx7r0w8.fsf@toke.dk>
Message-ID: <20210211172603.17d6a8f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 10 Feb 2021 23:52:39 +0100 Toke H?iland-J?rgensen wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > On Wed, 10 Feb 2021 11:53:53 +0100 Toke H?iland-J?rgensen wrote:  
> >> While I do agree that that kind of conformance test would be great, I
> >> don't think it has to hold up this series (the perfect being the enemy
> >> of the good, and all that). We have a real problem today that userspace
> >> can't tell if a given driver implements, say, XDP_REDIRECT, and so
> >> people try to use it and spend days wondering which black hole their
> >> packets disappear into. And for things like container migration we need
> >> to be able to predict whether a given host supports a feature *before*
> >> we start the migration and try to use it.  
> >
> > Unless you have a strong definition of what XDP_REDIRECT means the flag
> > itself is not worth much. We're not talking about normal ethtool feature
> > flags which are primarily stack-driven, XDP is implemented mostly by
> > the driver, each vendor can do their own thing. Maybe I've seen one
> > vendor incompatibility too many at my day job to hope for the best...  
> 
> I'm totally on board with documenting what a feature means.

We're trying documentation in devlink etc. and it's not that great.
It's never clear and comprehensive enough, barely anyone reads it.

> E.g., for
> XDP_REDIRECT, whether it's acceptable to fail the redirect in some
> situations even when it's active, or if there should always be a
> slow-path fallback.
> 
> But I disagree that the flag is worthless without it. People are running
> into real issues with trying to run XDP_REDIRECT programs on a driver
> that doesn't support it at all, and it's incredibly confusing. The
> latest example popped up literally yesterday:
> 
> https://lore.kernel.org/xdp-newbies/CAM-scZPPeu44FeCPGO=Qz=03CrhhfB1GdJ8FNEpPqP_G27c6mQ at mail.gmail.com/

To help such confusion we'd actually have to validate the program
against the device caps. But perhaps I'm less concerned about a
newcomer not knowing how to use things and more concerned about
providing abstractions which will make programs dependably working
across vendors and HW generations.

> >> I view the feature flags as a list of features *implemented* by the
> >> driver. Which should be pretty static in a given kernel, but may be
> >> different than the features currently *enabled* on a given system (due
> >> to, e.g., the TX queue stuff).  
> >
> > Hm, maybe I'm not being clear enough. The way XDP_REDIRECT (your
> > example) is implemented across drivers differs in a meaningful ways. 
> > Hence the need for conformance testing. We don't have a golden SW
> > standard to fall back on, like we do with HW offloads.  
> 
> I'm not disagreeing that we need to harmonise what "implementing a
> feature" means. Maybe I'm just not sure what you mean by "conformance
> testing"? What would that look like, specifically? 

We developed a pretty good set of tests at my previous job for testing
driver XDP as well as checking that the offload conforms to the SW
behavior. I assume any vendor who takes quality seriously has
comprehensive XDP tests.

If those tests were upstream / common so that we could run them
against every implementation - the features which are supported by 
a driver fall out naturally out of the set of tests which passed.
And the structure of the capability API could be based on what the
tests need to know to make a SKIP vs FAIL decision.

Common tests would obviously also ease the validation burden, burden of
writing tests on vendors and make it far easier for new implementations
to be confidently submitted.

> A script in selftest that sets up a redirect between two interfaces
> that we tell people to run? Or what? How would you catch, say, that
> issue where if a machine has more CPUs than the NIC has TXQs things
> start falling apart?

selftests should be a good place, but I don't mind the location.
The point is having tests which anyone (vendors and users) can run
to test their platforms. One of the tests should indeed test if every
CPU in the platform can XDP_REDIRECT. Shouldn't it be a rather trivial
combination of tun/veth, mh and taskset?

> > Also IDK why those tests are considered such a huge ask. As I said most
> > vendors probably already have them, and so I'd guess do good distros.
> > So let's work together.  
> 
> I guess what I'm afraid of is that this will end up delaying or stalling
> a fix for a long-standing issue (which is what I consider this series as
> shown by the example above). Maybe you can alleviate that by expanding a
> bit on what you mean?

I hope what I wrote helps a little. I'm not good at explaining. 

Perhaps I had seen one too many vendor incompatibility to trust that
adding a driver API without a validation suite will result in something
usable in production settings. 
