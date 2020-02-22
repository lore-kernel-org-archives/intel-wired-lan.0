From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 22 Feb 2020 02:01:51 +0000
Subject: [Intel-wired-lan] [PATCH] e1000: Distribute switch variables
 for initialization
In-Reply-To: <20200220062302.68898-1-keescook@chromium.org>
References: <20200220062302.68898-1-keescook@chromium.org>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971F92DA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kees Cook
> Sent: Wednesday, February 19, 2020 10:23 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Alexander Potapenko
> <glider@google.com>; Kees Cook <keescook@chromium.org>; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] e1000: Distribute switch variables for
> initialization
> 
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/net/ethernet/intel/e1000/e1000_main.c: In function
> ?e1000_xmit_frame?:
> drivers/net/ethernet/intel/e1000/e1000_main.c:3143:18: warning:
> statement will never be executed [-Wswitch-unreachable]
>  3143 |     unsigned int pull_size;
>       |                  ^~~~~~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
