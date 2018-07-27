From: Marco Berizzi <pupilla@libero.it>
Date: Fri, 27 Jul 2018 10:47:46 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
Message-ID: <1312873949.790150.1532681266921@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 26 luglio 2018 alle 18.05 Alexander Duyck <alexander.duyck@gmail.com> ha scritto:

> > > Also I assume
> > > this is a direct assigned port?
> > 
> > Apologies, but I did not understand this question.
> 
> Is the adapter above running in the VM and passed through, or is it
> just running in the host?

the problem is happening on the host machine.

> You mentioned virtualbox so I thought you
> were implying that this was being used inside of a VM.

no no. I mentioned virtualbox because it add kernel modules
to the vanilla kernel.
 
> I don't suppose by any chance you would be willing to try and bisect
> the issue? Unfortunately there haven't been that many changes to igb
> itself so my concern is that we are looking at a change in the traffic
> behavior and that is somehow triggering issues in igb. Being able to
> bisect it would be very useful.
> 
> > > Do you know if
> > > there are any reproduction steps that might let us start bisecting
> > > this, or that would at least allow us to reproduce the issue more
> > > quickly?
> > 
> > Impossibile for me to reproduce. I'm not able to understand
> > why/when it is happening.
> 
> We can try and see if we can reproduce it, but we haven't seen any
> similar issues in our validation environment so I don't know if we
> could be able to get to root cause as there isn't anything obvious
> that should be causing the issue.

I think I have found the problem. Apologies it is not related
to the kernel version.

> Specifically you could start by disabling TSO. If disabling that
> causes the issue to disappear then that would be at least a data-point
> that would push us toward the direction of identifying the root cause.
> Other than that the only other thing I could think of would be to look
> at disabling scatter-gather. But it is unlikely that it is causing the
> issue.

this machine (which is called Kaa) is connected to an HPE5130 switch.
There is only another machine running on the network with MTU=9000
(which is called Pleiadi).
The problem has started to pop up on Kaa when I changed the MTU on
Pleiadi from MTU=1500 to MTU=9000 (for fixing the same error message,
however Pleiadi is runnig on an older intel NIC)

see this thread:

https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20180326/012410.html

Let me know what kind of test should I do.

Should I disable the TSO? Or should I set all my linux boxes MTU to 1500?
