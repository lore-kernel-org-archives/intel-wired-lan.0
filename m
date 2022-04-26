From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 26 Apr 2022 13:34:34 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: fix crash when writing
 timestamp on rx rings
In-Reply-To: <20220422173905.23410-1-arkadiusz.kubalewski@intel.com>
References: <20220422173905.23410-1-arkadiusz.kubalewski@intel.com>
Message-ID: <e7fa973e-b50e-7983-d897-9d8fa7001853@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/22/2022 10:39 AM, Arkadiusz Kubalewski wrote:
> Do not allow to write timestamps on RX rings if PF is being configured.
> When PF is being configured RX rings can be freed or rebuilt. If at the same
> time timestamps are updated, the kernel will crash by dereferencing null RX
> ring pointer.
>
> PID: 1449   TASK: ff187d28ed658040  CPU: 34  COMMAND: "ice-ptp-0000:51"
>   #0 [ff1966a94a713bb0] machine_kexec at ffffffff9d05a0be
>   #1 [ff1966a94a713c08] __crash_kexec at ffffffff9d192e9d
>   #2 [ff1966a94a713cd0] crash_kexec at ffffffff9d1941bd
>   #3 [ff1966a94a713ce8] oops_end at ffffffff9d01bd54
>   #4 [ff1966a94a713d08] no_context at ffffffff9d06bda4
>   #5 [ff1966a94a713d60] __bad_area_nosemaphore at ffffffff9d06c10c
>   #6 [ff1966a94a713da8] do_page_fault at ffffffff9d06cae4
>   #7 [ff1966a94a713de0] page_fault at ffffffff9da0107e
>      [exception RIP: ice_ptp_update_cached_phctime+91]
>      RIP: ffffffffc076db8b  RSP: ff1966a94a713e98  RFLAGS: 00010246
>      RAX: 16e3db9c6b7ccae4  RBX: ff187d269dd3c180  RCX: ff187d269cd4d018
>      RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
>      RBP: ff187d269cfcc644   R8: ff187d339b9641b0   R9: 0000000000000000
>      R10: 0000000000000002  R11: 0000000000000000  R12: ff187d269cfcc648
>      R13: ffffffff9f128784  R14: ffffffff9d101b70  R15: ff187d269cfcc640
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #8 [ff1966a94a713ea0] ice_ptp_periodic_work at ffffffffc076dbef [ice]
>   #9 [ff1966a94a713ee0] kthread_worker_fn at ffffffff9d101c1b
>   #10 [ff1966a94a713f10] kthread at ffffffff9d101b4d
>   #11 [ff1966a94a713f50] ret_from_fork at ffffffff9da0023f
>
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---

This doesn't apply to net-queue.

Thanks,

Tony

