From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 22 Jun 2021 10:23:14 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3] ice: add tracepoints
In-Reply-To: <20210608233517.3135522-1-jesse.brandeburg@intel.com>
References: <20210608233517.3135522-1-jesse.brandeburg@intel.com>
Message-ID: <43730a28-ccc6-1898-97b5-b4833038a425@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jesse,


Am 09.06.21 um 01:35 schrieb Jesse Brandeburg:
> This patch is modeled after one by Scott Peterson for i40e.
> 
> Add tracepoints to the driver, via a new file ice_trace.h and some new
> trace calls added in interesting places in the driver. Add some tracing
> for DIMLIB to help debug interrupt moderation problems.
> 
> Performance should not be affected, and this can be very useful
> for debugging and adding new trace events to paths in the future.
> 
> Note eBPF programs can attach to these events, as well as perf
> can count them since we're attaching to the events subsystem
> in the kernel.
> 
> Co-developed-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> NOTE: checkpatch will complain about this patch due to the macros
> defining the new trace functionality being formatted for readability.
> 
> Testing Hints:
> See that performance is unaffected while tracepoints are present but
> disabled (default state). Enable them all and see they appear in
> /sys/kernel/debug/tracing/trace when exercised, and after 'make install'
> you can see the events in perf list.
> 
> When disabled, a tracepoint reduces to a 5-byte no-op. When enabled,
> that code is patched to jump to the tracepoint clause, which is located
> somewhere nearby.  See include/linux/jump_label.h for info in static
> keys, and samples/trace-events/trace-events-samples.[ch] for info on the
> trace events.
> 
> To test tracepoints:
> insmod ice and bring up a link
> cd /sys/kernel/debug/tracing
> echo > trace
> echo 1 > events/ice/enable
> send something over ice
> cat trace
> echo 0 > events/ice/enable

I?d put that example into the commit message.

[?]


Kind regards,

Paul
