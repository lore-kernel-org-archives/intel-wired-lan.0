From: Christopher Hall <christopher.s.hall@intel.com>
Date: Mon, 22 Feb 2016 10:33:47 -0800
Subject: [Intel-wired-lan] [PATCH v7 0/8] Patchset enabling hardware
 based cross-timestamps for next gen Intel platforms
In-Reply-To: <CALAqxLXFVSrGD75gw7FbDtJV_cua9oowit8y=nKGS-YG5cYXAw@mail.gmail.com>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <CALAqxLXFVSrGD75gw7FbDtJV_cua9oowit8y=nKGS-YG5cYXAw@mail.gmail.com>
Message-ID: <op.yc8y6lni1774gr@chall-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 18 Feb 2016 11:26:24 -0800, John Stultz <john.stultz@linaro.org>  
wrote:
> On Fri, Feb 12, 2016 at 12:25 PM, Christopher S. Hall
> <christopher.s.hall@intel.com> wrote:
>> Modern Intel hardware adds an Always Running Timer (ART) that allows the
>> network and audio device clocks to precisely cross timestamp the device
>> clock with the system clock. This allows a precise correlation of the
>> device time and system time.
>
> Thanks for your continued persistence here Christopher!  It is looking
> pretty good.
>
> I've queued these up for testing, and if that goes well, and don't hit
> anything else in review, I'll likely try to submit all but the last
> patch (unless there's an acked-by from the maintainer of that code)
> through Thomas for 4.6.

Hi John,

I just sent another patchset (v8). I corrected the comment problems  
pointed out by Richard Cochran. I also changed the arch/x86 code to use  
"non-stop" TSC rather than "invariant" TSC. They are *exactly* the same  
thing (i.e. read from the same bit of the CPUID leaf). The former exists  
already and should be used instead.  Patch 6/8 is the only patch that is  
changed apart from comments.

Thanks for your help reviewing this.

Chris
