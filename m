From: John Stultz <john.stultz@linaro.org>
Date: Tue, 20 Oct 2015 13:16:29 -0700
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <alpine.DEB.2.11.1510202107410.8159@nanos>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1510132116480.25029@nanos>
 <op.x6iyd7gq1774gr@chall-mobl2.amr.corp.intel.com>
 <alpine.DEB.2.11.1510151014330.3960@nanos>
 <op.x6r25dza1774gr@chall-mobl2.amr.corp.intel.com>
 <CALAqxLXu_C8sWaKyxqXJPFV+m5Zdk=4q4s7O6NoLR1B8bbyuxg@mail.gmail.com>
 <20151020085408.GA2542@netboy>
 <alpine.DEB.2.11.1510201246250.3982@nanos>
 <20151020115113.GA23428@netboy> <20151020145523.GA5207@netboy>
 <alpine.DEB.2.11.1510202107410.8159@nanos>
Message-ID: <CALAqxLXGnzwH5OgDCyggzxbao7UvS6_SOtVVkNVmjrsrOL-YBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 20, 2015 at 12:11 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 20 Oct 2015, Richard Cochran wrote:
>> On Tue, Oct 20, 2015 at 01:51:13PM +0200, Richard Cochran wrote:
>> > You can, in fact, achieve "proper" correlation by sampling.  As John
>> > said, the question is whether the method in the patch set "measurably
>> > improves the error" over using another, simpler method.
>>
>> Here is a short example to put some numbers on the expected error.
>> Let the driver sample at an interval of 1 ms.  If the system time's
>> frequency hasn't changed between two samples, A and B, then the driver
>> may interpolate without introducing any error.
>
> Darn, we don't want to have that kind of sampling in every driver
> which has this kind of problem even if it looks like the simpler
> choice for this particular use case. This is going to be something
> which next generation chips will have on more than just the audio
> interface and we realy want to have a generic solution for this.

I sort of agree with Richard that the timekeeper history approach
doesn't seem like a generic solution here.

And again, you seem to be speaking with a bigger picture in mind that
at least I don't yet share (apologies for being thick headed here).
Being able to have various hardware sharing a time base is quite
useful, and methods for correlating timestamps together are useful.
But I don't yet really understand why its important that we can
translate a hardware timestamp from some time in the past to the
correct system time in the past without error.

thanks
-john
