From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 13 Nov 2020 11:10:58 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201113032451.GB32138@hoboy.vegasvil.org>
References: <20201112093203.GH1559650@localhost> <87pn4i6svv.fsf@intel.com>
 <20201113032451.GB32138@hoboy.vegasvil.org>
Message-ID: <87ima96pj1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Richard,

Richard Cochran <richardcochran@gmail.com> writes:

> On Thu, Nov 12, 2020 at 03:46:12PM -0800, Vinicius Costa Gomes wrote:
>> I wanted it so using PCIe PTM was transparent to applications, so adding
>> another API wouldn't be my preference.
>> 
>> That being said, having a trigger from the application to start/stop the
>> PTM cycles doesn't sound too bad an idea. So, not too opposed to this
>> idea.
>> 
>> Richard, any opinions here?
>
> Sorry, I only have the last two message from this thread, and so I'm
> missing the backstory.

No worries. The not so short version of the story is this:

I am proposing a series that adds support for PCIe PTM (for the igc
driver), exporting the values via the PTP_SYS_OFFSET_PRECISE ioctl().

The way PTM works in the NIC I have, kind of forces me to start the PTM
dialogs during initialization, and they are kept running in background,
what the _PRECISE ioctl() does is basically collecting the most recent
measurement.

Miroslav is suggesting that a new API, similar to PTP_EXTTS_REQUEST,
would be a good idea.

This new API idea has a few nice "pros":
 - I can use it to trigger starting the PTM cycles (instead of starting
 PTM during initialization), and the application would potentially have
 access to all the measurements;
 - Right now, keeping the PTM cycles always running would probably have
 an impact in power comsuption/number of wake-ups, with this new API,
 this price would only be paid when the user wants.

The main "con" would be that it wouldn't be transparent to applications
(phc2sys), as it would have to use another API if it wants to take
advantage of PTM.

And so question is, what is your opinion on this: export the PTM
measurements using some "to be defined" new API or keep using some of
the PTP_SYS_OFFSET_* ioctls?

I think that's it. Miroslav, feel free to correct me if I missed
something.


Cheers,
-- 
Vinicius
