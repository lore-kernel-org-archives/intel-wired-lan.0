From: Limonciello, Mario <Mario.Limonciello@dell.com>
Date: Tue, 8 Dec 2020 22:29:10 +0000
Subject: [Intel-wired-lan] [PATCH v3 0/7] Improve s0ix flows for systems
 i219LM
In-Reply-To: <CAKgT0UebNROCeAyyg0Jf-pTfLDd-oNyu2Lo-gkZKWk=nOAYL8g@mail.gmail.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <d0f7e565-05e1-437e-4342-55eb73daa907@redhat.com>
 <DM6PR19MB2636A4097B68DBB253C416D8FACE0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <383daf0d-8a9b-c614-aded-6e816f530dcd@intel.com>
 <e7d57370-e35e-a9e6-2dd9-aa7855c15650@redhat.com>
 <CAKgT0UebNROCeAyyg0Jf-pTfLDd-oNyu2Lo-gkZKWk=nOAYL8g@mail.gmail.com>
Message-ID: <DM6PR19MB2636BAAB459B3895EC5F0A98FACD0@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> 
> Based on the earlier thread you had referenced and his comment here it
> sounds like while adding time will work for most cases, it doesn't
> solve it for all cases. The problem is as a vendor you are usually
> stuck looking for a solution that will work for all cases which can
> lead to things like having to drop features because they can be
> problematic for a few cases.
> 
> > Are you saying that you insist on keeping the e1000e_check_me check and
> > thus needlessly penalizing 100s of laptops models with higher
> > power-consumption unless these 100s of laptops are added manually
> > to an allow list for this?
> >
> > I'm sorry but that is simply unacceptable, the maintenance burden
> > of that is just way too high.
> 
> Think about this the other way though. If it is enabled and there are
> cases where adding a delay doesn't resolve it then it still doesn't
> really solve the issue does it?
> 
> > Testing on the models where the timeout issue was first hit has
> > shown that increasing the timeout does actually fix it on those
> > models. Sure in theory the ME on some buggy model could hold the
> > semaphore even longer, but then the right thing would be to
> > have a deny-list for s0ix where we can add those buggy models
> > (none of which we have encountered sofar). Just like we have
> > denylist for buggy hw in other places in the kernel.
> 
> This would actually have a higher maintenance burden then just
> disabling the feature. Having to individually test for and deny-list
> every one-off system with this bad configuration would be a pretty
> significant burden. That also implies somebody would have access to
> such systems and that is not normally the case. Even Intel doesn't
> have all possible systems that would include this NIC.
> 
> > Maintaining an ever growing allow list for the *theoretical*
> > case of encountering a model where things do not work with
> > the increased timeout is not a workable and this not an
> > acceptable solution.
> 
> I'm not a fan of the allow-list either, but it is preferable to a
> deny-list where you have to first trigger the bug before you realize
> it is there. Ideally there should be another solution in which the ME
> could somehow set a flag somewhere in the hardware to indicate that it
> is alive and the driver could read that order to determine if the ME
> is actually alive and can skip this workaround. Then this could all be
> avoided and it can be safely assumed the system is working correctly.
> 
> > The initial addition of the e1000e_check_me check instead
> > of just going with the confirmed fix of bumping the timeout
> > was already highly controversial and should IMHO never have
> > been done.
> 
> How big was the sample size for the "confirmed" fix? How many
> different vendors were there within the mix? The problem is while it
> may have worked for the case you encountered you cannot say with
> certainty that it worked in all cases unless you had samples of all
> the different hardware out there.

+1
IIRC it was just Lenovo that was checked and just a few systems.

> 
> > Combining this with an ever-growing allow-list on which every
> > new laptop model needs to be added separately + a new
> > "s0ix-enabled" ethertool flag, which existence is basically
> > an admission that the allow-list approach is flawed goes
> > from controversial to just plain not acceptable.
> 
> I don't view this as problematic, however this is some overhead to it.
> One thing I don't know is if anyone has looked at is if the issue only
> applies to a few specific system vendors. Currently the allow-list is
> based on the subdevice ID. One thing we could look at doing is
> enabling it based on the subvendor ID in which case we could
> allow-list in large swaths of hardware with certain trusted vendors.

Although it would decrease the overhead my preference is that we don't lump
all of an OEM's hardware together until it's actually been checked.  It's going
to be very 
Even in a single OEM there are a variety of
BIOS vendors in the mix, different ODMs working assisting on designs, and lots
of moving pieces of firmware during development.  You'll notice I intentionally
have only included a subset of Dell's TGL designs in the later patches and
separated them out for easy reverts in the series because they're far enough
in development to be considered a stable baseline and have been validated.

I'm a fan of collapsing the lists and heuristics after a generation of systems
is done if they can all be checked, but beyond that it becomes very difficult
to pull out one single system that has a failure.

> The only issue is that it pulls in any future parts as well so it puts
> the onus on that manufacturer to avoid misconfiguring things in the
> future.

As Sasha said it's not a POR configuration right now.  So until it's become
POR configuration it should be case by case basis enabled where it works.

