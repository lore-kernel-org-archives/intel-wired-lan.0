From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Apr 2017 21:42:16 +0000
Subject: [Intel-wired-lan] [next PATCH S70 01/12] i40e/i40evf:
	Add	tracepoints
In-Reply-To: <20170413084555.6962-1-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B9D1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 01/12] i40e/i40evf: Add
> tracepoints
> 
> From: "Peterson, Scott D" <scott.d.peterson@intel.com>
> 
> This patch adds tracepoints to the i40e and i40evf drivers to which BPF
> programs can be attached for feature testing and verification.
> It's expected that an attached BPF program will identify and count or log
> some interesting subset of traffic. The bcc-tools package is helpful there for
> containing all the BPF arcana in a handy Python wrapper. Though you can
> make these tracepoints log trace messages, the messages themselves
> probably won't be very useful (other to verify the tracepoint is being called
> while you're debugging your BPF program).
> 
> The idea here is that tracepoints have such low performance cost when
> disabled that we can leave these in the upstream drivers. This may
> eventually enable the instrumentation of unmodified customer systems
> should the need arise to verify a NIC feature is working as expected.
> In general this enables one set of feature verification tools to be used on
> these drivers whether they're built with the kernel or separately.
> 
> Users are advised against using these tracepoints for anything other than a
> diagnostic tool. They have a performance impact when enabled, and their
> exact placement and form may change as we see how well they work in
> practice for the purposes above.
> 
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> Change-ID: Id6014a7322c0e6d08068114dd20bd156f2f6435e
> ---
> Testing Hints:
> 
> See that performance is unaffected while tracepoints are present but
> disabled (default state). Enable them all and see they appear in
> /sys/kernel/debug/tracing/trace when exercised.
> 
> When disabled, a tracepoint reduces to a 5-byte no-op.
> When enabled, that code is patched to jump to the tracepoint clause, which
> is located somewhere nearby.  See include/linux/jump_label.h for info in
> static keys, and samples/trace-events/trace-events-samples.[ch]
> for info on the trace events.
> 
> To test tracepoints:
> insmod i40e and bring up a link
> cd /sys/kernel/debug/tracing
> echo > trace
> echo 1 > events/i40e/enable
> send something over i40e
> more trace
> echo 0 > events/i40e/enable
> 
> i40evf trace events are in events/i40evf, and enabled separately.
> 
> A sample BPF program (CORE/example_tp_bpf.py) is available, but won't be
> submitted upstream and so is not included in this patch.
> 
> It demonstrates how to access the structures pointed to by the tracepoint
> args from BPF. See the comments in that script for details and usage. As is it
> will attach itself to one of these tracepoints and emit mostly useless
> messages when the i40e_clean_rx_irq tracepoint is invoked.
>  drivers/net/ethernet/intel/i40e/Makefile        |   3 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |   6 +
>  drivers/net/ethernet/intel/i40e/i40e_trace.h    | 229
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   9 +
>  drivers/net/ethernet/intel/i40evf/Makefile      |   3 +
>  drivers/net/ethernet/intel/i40evf/i40e_trace.h  | 229
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   9 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   7 +
>  8 files changed, 495 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


