From: JD <jdtxs00@gmail.com>
Date: Thu, 17 Oct 2019 17:02:59 -0500
Subject: [Intel-wired-lan] VF/SRIOV question
In-Reply-To: <CAKgT0UeDcXSjcXs+V9z+aAkg079Ltt1rEHXxr4Ug-E-GB92=OQ@mail.gmail.com>
References: <CAMnf+Phw525rfCHVDXz1uWZw4Y=HuyBjnhpqYzjx2dmgpsHMsA@mail.gmail.com>
 <CAKgT0UeDcXSjcXs+V9z+aAkg079Ltt1rEHXxr4Ug-E-GB92=OQ@mail.gmail.com>
Message-ID: <CAMnf+PjUjCbhh82QJ=y=pN7jDOYwXnr8oAi7wBUoHBHPR7OO=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

That clears things up. Thank you very much for your reply and insight!

On Thu, Oct 17, 2019 at 3:47 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 11:06 AM JD <jdtxs00@gmail.com> wrote:
> >
> > Hello,
> >
> > I couldn't find anything in the spec/doc for the Intel 82599 series
> > NIC's regarding performance penalties with a higher number of VF's.
> >
> > Currently I'm using 16 VF's with SR-IOV/QEMU, but the 82599 NIC
> > supports up to 63 VF's. From a driver/NIC perspective, are there any
> > performance considerations or penalties of enabling/using all of the
> > available VF's on a NIC?
> >
> > If there isn't, is this the same case for other models (besides 82599) as well?
> >
> > Thank you!
>
> One hardware limitation I am aware of is that as you spread the work
> over more queues, or in this case more VFs you may not be able to
> achieve 64B line rate with small packets. The issue is as you add more
> queues the descriptor fetching becomes more interleaved between the
> queues which will reduce the performance. So instead of being able to
> hit 14.88Mpps you may only see about 10 or 11Mpps. If you are working
> with packets larger than 128B or larger you should see little to no
> impact.
>
> Another limitation I can think of is the number of queues per PF/VF.
> The hardware only has a certain number of queues. For 82599 that
> number is 128. So when you have 31 or fewer VFs you get 4 queues for
> the PF, when you have 32 or more the PF has to drop to 2 queues.
> Depending on your workload this may mean more stress on the CPUs
> handling PF traffic as the number of queues is reduced.
>
> Hope that helps.
>
> - Alex
