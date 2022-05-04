From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 4 May 2022 11:39:57 +0200
Subject: [Intel-wired-lan] [PATCH net v3] ice: fix crash when writing
 timestamp on rx rings
In-Reply-To: <20220428083350.10986-1-arkadiusz.kubalewski@intel.com>
References: <20220428083350.10986-1-arkadiusz.kubalewski@intel.com>
Message-ID: <CADEbmW2-j8x+rcxt2dGsMfKyL9kGLU6SRO+EkWn0oyOAAmkEXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 28, 2022 at 10:46 AM Arkadiusz Kubalewski <
arkadiusz.kubalewski@intel.com> wrote:

> Do not allow to write timestamps on RX rings if PF is being configured.
> When PF is being configured RX rings can be freed or rebuilt. If at the
> same
> time timestamps are updated, the kernel will crash by dereferencing null RX
> ring pointer.
>
> PID: 1449   TASK: ff187d28ed658040  CPU: 34  COMMAND: "ice-ptp-0000:51"
>  #0 [ff1966a94a713bb0] machine_kexec at ffffffff9d05a0be
>  #1 [ff1966a94a713c08] __crash_kexec at ffffffff9d192e9d
>  #2 [ff1966a94a713cd0] crash_kexec at ffffffff9d1941bd
>  #3 [ff1966a94a713ce8] oops_end at ffffffff9d01bd54
>  #4 [ff1966a94a713d08] no_context at ffffffff9d06bda4
>  #5 [ff1966a94a713d60] __bad_area_nosemaphore at ffffffff9d06c10c
>  #6 [ff1966a94a713da8] do_page_fault at ffffffff9d06cae4
>  #7 [ff1966a94a713de0] page_fault at ffffffff9da0107e
>     [exception RIP: ice_ptp_update_cached_phctime+91]
>     RIP: ffffffffc076db8b  RSP: ff1966a94a713e98  RFLAGS: 00010246
>     RAX: 16e3db9c6b7ccae4  RBX: ff187d269dd3c180  RCX: ff187d269cd4d018
>     RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
>     RBP: ff187d269cfcc644   R8: ff187d339b9641b0   R9: 0000000000000000
>     R10: 0000000000000002  R11: 0000000000000000  R12: ff187d269cfcc648
>     R13: ffffffff9f128784  R14: ffffffff9d101b70  R15: ff187d269cfcc640
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ff1966a94a713ea0] ice_ptp_periodic_work at ffffffffc076dbef [ice]
>  #9 [ff1966a94a713ee0] kthread_worker_fn at ffffffff9d101c1b
>  #10 [ff1966a94a713f10] kthread at ffffffff9d101b4d
>  #11 [ff1966a94a713f50] ret_from_fork at ffffffff9da0023f
>
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
> v2: rebased to latest dev-queue
> v3: use proper if statement condition to bail out
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Dave Cain <dcain@redhat.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220504/e927bf62/attachment.html>
