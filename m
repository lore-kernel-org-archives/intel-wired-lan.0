From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Nov 2017 22:48:01 +0000
Subject: [Intel-wired-lan] [PATCH net] sched/deadline: fix one-bit
 signed bitfields to be unsigned
In-Reply-To: <20171121223030.28051-1-jacob.e.keller@intel.com>
References: <20171121223030.28051-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAF8DF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, November 21, 2017 2:31 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Peter Zijlstra <peterz@infradead.org>; luca abeni
> <luca.abeni@santannapisa.it>; Ingo Molnar <mingo@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net] sched/deadline: fix one-bit signed
> bitfields to be unsigned
> 
> Commit 799ba82de01e ("sched/deadline: Use C bitfields for the state flags",
> 2017-10-10) introduced the use of C bitfields for these variables. However,
> sparse complains about them:
> 
> ./include/linux/sched.h:476:62: error: dubious one-bit signed bitfield
> ./include/linux/sched.h:477:62: error: dubious one-bit signed bitfield
> ./include/linux/sched.h:478:62: error: dubious one-bit signed bitfield
> ./include/linux/sched.h:479:62: error: dubious one-bit signed bitfield
> 
> This is because a one-bit signed bitfield can only hold the values 0 and -1,
> which can cause problems if the program expects to be able to represent the
> value positive 1.
> 
> In practice, this may not cause a bug since -1 would be considered "true" in
> logical tests, however we should avoid the practice anyways.
> 
> Fixes: 799ba82de01e ("sched/deadline: Use C bitfields for the state flags",
> 2017-10-10)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: luca abeni <luca.abeni@santannapisa.it>
> ---
>  include/linux/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


