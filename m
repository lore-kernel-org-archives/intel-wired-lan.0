From: John Stultz <john.stultz@linaro.org>
Date: Mon, 22 Feb 2016 10:49:46 -0800
Subject: [Intel-wired-lan] [PATCH v7 0/8] Patchset enabling hardware
 based cross-timestamps for next gen Intel platforms
In-Reply-To: <op.yc8y6lni1774gr@chall-mobl2.amr.corp.intel.com>
References: <1455308729-6280-1-git-send-email-christopher.s.hall@intel.com>
 <CALAqxLXFVSrGD75gw7FbDtJV_cua9oowit8y=nKGS-YG5cYXAw@mail.gmail.com>
 <op.yc8y6lni1774gr@chall-mobl2.amr.corp.intel.com>
Message-ID: <CALAqxLUD+-_AxXX7hbCsbe2jpytFeDJQQSAr0EHy3dX1V+GoxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Feb 22, 2016 at 10:33 AM, Christopher Hall
<christopher.s.hall@intel.com> wrote:
> I just sent another patchset (v8). I corrected the comment problems pointed
> out by Richard Cochran. I also changed the arch/x86 code to use "non-stop"
> TSC rather than "invariant" TSC. They are *exactly* the same thing (i.e.
> read from the same bit of the CPUID leaf). The former exists already and
> should be used instead.  Patch 6/8 is the only patch that is changed apart
> from comments.

Ok. So I see you addressed some of Andy's feedback, but did you answer
the bit about the k offset?

thanks
-john
