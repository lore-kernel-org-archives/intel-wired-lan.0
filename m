From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Dec 2015 13:11:12 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing the
	kernel
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EDC32FE@ORSMSX105.amr.corp.intel.com>
References: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
 <CAKgT0Uc7ezCCqYa_n_SpOkm0P9TpEs3m3pOjb9o_Rx8hD_L0pg@mail.gmail.com>
 <804857E1F29AAC47BF68C404FC60A1847EDC32FE@ORSMSX105.amr.corp.intel.com>
Message-ID: <CAKgT0Uf0XAi3a+=ge0y-xg1wt8XaKw3YMNycXKKuk8w0kL92FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 23, 2015 at 12:19 PM, Allan, Bruce W
<bruce.w.allan@intel.com> wrote:

> Compilers are very smart today.  This patch works as described (i.e. causes build errors) when idx would not equal the defined constant where it is checked against for all available levels of optimization in gcc.
>
> It does generate an undesirable error with -O0 and -Og even if idx would equal the defined constant, but with those optimization levels errors would be generated for other similar instances of BUILD_BUG_ON() in the rest of the kernel source (not to mention a significant number of other "errors").

I had a hard time believing it was optimizing to this level, but it
looks like you are right.  On my system I do see the BUILD_BUG_ON
triggered if I tweak FM10K_REGS_LEN_VSI which was my concern since I
wasn't sure it would unroll all the loop logic, but it looks like it
did it enough with either -Os or -O2 to work correctly.  I'll go ahead
and throw my ack in there since it seems like this works, and I
suspect worse case scenario would be that the some compilers may just
ignore it if they don't take care of the loop unrolling.

Acked-by: Alexander Duyck <aduyck@mirantis.com>
