From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Mon, 22 May 2017 16:40:34 +0000
Subject: [Intel-wired-lan] [PATCH 0/4] Configuring traffic classes via
 new hardware offload mechanism in tc/mqprio
In-Reply-To: <CAJ3xEMhtgt4==-GbAWjT8fGMQhoRAzHhFbaVgrfWgJhSaxXr9g@mail.gmail.com>
References: <149524122523.11022.4541073724650541658.stgit@anamdev.jf.intel.com>
 <CAJ3xEMjTDW7sQ5CFmTyR5xMpin_WFFQg-S8imWMBpXWuS1zvVw@mail.gmail.com>
 <CAKgT0Ue6tDOE8L4thktyje-erGkVMmtO7zyp0FRgmRPYOppjQA@mail.gmail.com>
 <CAJ3xEMhtgt4==-GbAWjT8fGMQhoRAzHhFbaVgrfWgJhSaxXr9g@mail.gmail.com>
Message-ID: <1495471231.2562.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-05-22 at 06:25 +0300, Or Gerlitz wrote:
> On Mon, May 22, 2017 at 1:35 AM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > 
> > On Sat, May 20, 2017 at 2:15 PM, Or Gerlitz <gerlitz.or@gmail.com> wrote:
> > > 
> > > On Sat, May 20, 2017 at 3:58 AM, Amritha Nambiar
> > > <amritha.nambiar@intel.com> wrote:
> > > > 
> > > > The following series introduces a new harware offload mode in tc/mqprio
> > > 
> > > Wait, we have already a HW QoS model introduced by John F and Co
> > > couple of years ago,  right?
> > 
> > I assume you are referring to the ETS portion of DCBX? If so then yes
> > we have something there, but there is a fairly high level of
> > complexity and dependencies in order to enable that. What we have in
> > mind doesn't really fit with DCBX and the problem is the spec calls
> > out that you really have to have support for DCBX in order to make use
> > of ETS. What we are trying to do here is provide a lightweight way of
> > doing this configuration similar to how mqprio was already providing a
> > lightweight way of enabling multiple traffic classes.
> 
> UAPI wise, we are talking on DCB, not DCBX, right? the X-portion comes
> into play if some user-space entity run LLDP traffic and calls into
> the kernel to configure (say) ETS. If there are some issues to use the
> existing user-space tool (lldpad tool/daemon) to do DCB without X, one
> can/should fix them or introduce another/simpler tool that in a
> lightweight manner only configures things w.o exchanging.
> 
> So to clarify, the essence of this series is introducing a 2nd way to
> configure ETS and rate limit?

Sort of. Basically the idea is we can use several different approaches
to enable queue configuration and rate limits. So we are adding two
pieces of functionality.

The first block allows for configuring queue counts and layout.
Historically DCB/DCBX hasn't allowed us to specify that.

The second bit is that we added support for rate limiting. I am
actually basing it on what we had for SR-IOV rate limiting as that is
how this is working in i40e. However the basic attributes we are adding
should work for most ETS type use cases though it might need to use the
min rates instead of the max rates as we do in i40e.

> > 
> > > 
> > > Please elaborate in few sentence if you are extending it/replacing it,
> > > why we want to do that and what are the implications on existing
> > > applications UAPI wise.
> 
> > 
> > This is meant to be an extension of the existing structure. It can be
> > ignored by the driver and instead only have the basic hw offload
> > supported. In such a case the command will still return success but
> > any rate limits and queue configuration can be ignored. In the case of
> > the current implementation the queue configuration was already being
> > ignored so we opted to re-purpose the "hw" flag so that if you pass a
> > value greater than 1 and the driver doesn't recognize the value it has
> > the option to just ignore the extra bits it doesn't recognize and
> > return 1 as it did before for the hw flag in mqprio.
> 
> So the user asked to configure something and the kernel returned
> success but the config was not plugged to the hw? sounds to me like
> possible (probable) source of troubles and complaints.

That is possible, however the issue already existed. The queue
configuration could be specified with the mqprio configuration and be
totally ignored. I opted for just maintaining the existing behavior and
moving forward and providing some input via the ability to report what
"version" of the hardware offload we are supporting.

The plan is that legacy devices can fall back into the setup where they
support mode 1, however if they support hw mode 2 then we will fail to
initialize if we don't support something that is being requested.

> > 
> > > 
> > > Below you just say in the new mode Qos is configured with knobs XYZ --
> > > this is way not enough
> 
> > 
> > Can you clarify what you are asking for here? Amritha included an
> > example in patch 1 of a command line that enabled 2 traffic classes
> > with rate limits. Is there something more specific you are looking for?
> 
> you were referring to the questions I posted, so we can continue the
> discussion from here.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
