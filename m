From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 9 Nov 2018 23:29:29 +0000
Subject: [Intel-wired-lan] [net-next v2 2/2] ethernet/intel: consolidate
 napi and napi exit
In-Reply-To: <20181108225532.26078-1-jeffrey.t.kirsher@intel.com>
References: <20181108225532.26078-1-jeffrey.t.kirsher@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5884D20C8D@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Jeff
> Kirsher
> Sent: Thursday, November 08, 2018 2:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next v2 2/2] ethernet/intel: consolidate napi and napi
> exit
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> While reviewing code, I noticed that Eric Dumazet recommends that
> drivers check the return code of napi_complete_done, and use that
> to decide to enable interrupts or not when exiting poll.  One of
> the Intel drivers was already fixed (ixgbe).
> 
> Upon looking at the Intel drivers as a whole, we are handling our
> polling and napi exit in a few different ways based on whether we
> have multiqueue and whether we have tx cleanup included. Several
> drivers had the bug of exiting napi with return 0, which appears
> to mess up the accounting in the stack.
> 
> Consolidate all the napi routines to do best known way of exiting
> and to just mostly look like each other.
> 1) check return code of napi_complete_done to control interrupt enable
> 2) return the actual amount of work done.
> 3) return budget immediately if need napi poll again
> 
> Tested the changes on e1000e with a high interrupt rate set, and
> it shows about an 8% reduction in the CPU utilization when busy
> polling because we aren't re-enabling interrupts when we're about
> to be polled.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

The fm10k changes look good to me. Thanks Jesse! For those:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
