From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 10 Feb 2021 10:31:35 -0800
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <874kikry66.fsf@toke.dk>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
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
Message-ID: <20210210103135.38921f85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 10 Feb 2021 11:53:53 +0100 Toke H?iland-J?rgensen wrote:
> >> I am a bit confused now. Did you mean validation tests of those XDP
> >> flags, which I am working on or some other validation tests?
> >> What should these tests verify? Can you please elaborate more on the
> >> topic, please - just a few sentences how are you see it?  
> >
> > Conformance tests can be written for all features, whether they have 
> > an explicit capability in the uAPI or not. But for those that do IMO
> > the tests should be required.
> >
> > Let me give you an example. This set adds a bit that says Intel NICs 
> > can do XDP_TX and XDP_REDIRECT, yet we both know of the Tx queue
> > shenanigans. So can i40e do XDP_REDIRECT or can it not?
> >
> > If we have exhaustive conformance tests we can confidently answer that
> > question. And the answer may not be "yes" or "no", it may actually be
> > "we need more options because many implementations fall in between".
> >
> > I think readable (IOW not written in some insane DSL) tests can also 
> > be useful for users who want to check which features their program /
> > deployment will require.  
> 
> While I do agree that that kind of conformance test would be great, I
> don't think it has to hold up this series (the perfect being the enemy
> of the good, and all that). We have a real problem today that userspace
> can't tell if a given driver implements, say, XDP_REDIRECT, and so
> people try to use it and spend days wondering which black hole their
> packets disappear into. And for things like container migration we need
> to be able to predict whether a given host supports a feature *before*
> we start the migration and try to use it.

Unless you have a strong definition of what XDP_REDIRECT means the flag
itself is not worth much. We're not talking about normal ethtool feature
flags which are primarily stack-driven, XDP is implemented mostly by
the driver, each vendor can do their own thing. Maybe I've seen one
vendor incompatibility too many at my day job to hope for the best...

> I view the feature flags as a list of features *implemented* by the
> driver. Which should be pretty static in a given kernel, but may be
> different than the features currently *enabled* on a given system (due
> to, e.g., the TX queue stuff).

Hm, maybe I'm not being clear enough. The way XDP_REDIRECT (your
example) is implemented across drivers differs in a meaningful ways. 
Hence the need for conformance testing. We don't have a golden SW
standard to fall back on, like we do with HW offloads.

Also IDK why those tests are considered such a huge ask. As I said most
vendors probably already have them, and so I'd guess do good distros.
So let's work together.

> The simple way to expose the latter would be to just have a second set
> of flags indicating the current configured state; and for that I guess
> we should at least agree what "enabled" means; and a conformance test
> would be a way to do this, of course.
> 
> I don't see why we can't do this in stages, though; start with the first
> set of flags ('implemented'), move on to the second one ('enabled'), and
> then to things like making the kernel react to the flags by rejecting
> insertion into devmaps for invalid interfaces...
