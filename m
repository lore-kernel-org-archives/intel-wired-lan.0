From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 12 Nov 2020 15:46:12 -0800
Subject: [Intel-wired-lan] [PATCH next-queue v2 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20201112093203.GH1559650@localhost>
References: <20201112093203.GH1559650@localhost>
Message-ID: <87pn4i6svv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Miroslav Lichvar <mlichvar@redhat.com> writes:

> Considering how the existing applications work, ideally the
> measurements would be performed on demand from the ioctl to minimize
> the delay. If that's not possible, maybe it would be better to provide
> the measurements on a descriptor at their own rate, which could be
> polled by the applications, similarly to how the PTP_EXTTS_REQUEST
> ioctl works?

I wanted it so using PCIe PTM was transparent to applications, so adding
another API wouldn't be my preference.

That being said, having a trigger from the application to start/stop the
PTM cycles doesn't sound too bad an idea. So, not too opposed to this
idea.

Richard, any opinions here?

> That sounds like it could break in some specific conditions. Please
> try slightly different -R values and when it's running, try inserting
> a step with date -s '+0.1 sec' and see how reliable is the recovery.
> You can also test it with a different servo: phc2sys -E linreg.

Yeah, for some combinations, the disturbances make the recovery take
more time. So, I have to increase the frequency that the PTM cycles are
run. Thanks.

> Is that the case even when there is a PTM-enabled switch between the
> CPU and NIC? My understanding of the spec is that the switches are
> supposed to have their own clocks and have separate PTM dialogs on
> their upstream and downstream ports. In terms of PTP, are the switches
> boundary or transparent clocks?

Yeah, it seems that PCIe PTM switches are indeed more like boundary
clocks i.e. they are Requesters for the Root Complex and Responders for
the endpoints, and the Master time that they provide in their Responses
are in relation to their own clocks.

>
> Yes, I think that would work, except the delay would need to be
> doubled in the T3' calculation. The important thing is that the offset
> and delay calculated from the timestamps don't change. It might be
> better to shift the timestamps back to avoid the "post" timestamp
> coming from future, which applications could drop as invalid. To not
> shift the middlepoints in the conversion, this should work:
>
> T1' = (T2 + T3) / 2 - delay
> T2' = (T1 + T4) / 2
> T3' = (T2 + T3) / 2 + delay

Makes total sense. Thanks a lot!


Cheers,
-- 
Vinicius
