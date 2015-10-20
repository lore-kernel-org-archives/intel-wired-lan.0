From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 20 Oct 2015 16:55:23 +0200
Subject: [Intel-wired-lan] [PATCH v4 1/4] Produce system time from
	correlated clocksource
In-Reply-To: <20151020115113.GA23428@netboy>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-2-git-send-email-christopher.s.hall@intel.com>
 <alpine.DEB.2.11.1510132116480.25029@nanos>
 <op.x6iyd7gq1774gr@chall-mobl2.amr.corp.intel.com>
 <alpine.DEB.2.11.1510151014330.3960@nanos>
 <op.x6r25dza1774gr@chall-mobl2.amr.corp.intel.com>
 <CALAqxLXu_C8sWaKyxqXJPFV+m5Zdk=4q4s7O6NoLR1B8bbyuxg@mail.gmail.com>
 <20151020085408.GA2542@netboy>
 <alpine.DEB.2.11.1510201246250.3982@nanos>
 <20151020115113.GA23428@netboy>
Message-ID: <20151020145523.GA5207@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 20, 2015 at 01:51:13PM +0200, Richard Cochran wrote:
> You can, in fact, achieve "proper" correlation by sampling.  As John
> said, the question is whether the method in the patch set "measurably
> improves the error" over using another, simpler method.

Here is a short example to put some numbers on the expected error.
Let the driver sample at an interval of 1 ms.  If the system time's
frequency hasn't changed between two samples, A and B, then the driver
may interpolate without introducing any error.

If the frequency is changed between the sample times, then the
interpolated value will have some error.  Because 1 ms is smallest HZ
value, the frequency can change at most once during the sample.  If
the frequency changes near point A or B, then the error is minimal.
The worst case occurs when the frequency is changed half way between A
and B.

Suppose the frequency is changed by 10 PPM, at point C, half way
between A and B.  This change results in a 5 nanosecond time
difference at B (10 PPM over C -> B).  The driver will interpolate
using line A-B with slope increased by 5 PPM, and the worst case
error, found at point C, is then 2.5 nanoseconds.

Thanks,
Richard
