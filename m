From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:16:19 +0000
Subject: [Intel-wired-lan] [PATCH v3 11/16] fm10k: prepare_for_reset()
 when	we lose PCIe Link
In-Reply-To: <20170710202319.22110-11-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-11-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF6740@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, July 10, 2017 1:23 PM
> To: jtkirhse at osuosl.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: jekeller at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 11/16] fm10k: prepare_for_reset() when
> we lose PCIe Link
> 
> If we lose PCIe link, such as when an unannounced PFLR event occurs, or
> when a device is surprise removed, we currently detach the device and
> close the netdev. This unfortunately leaves a lot of things still
> active, such as the msix_mbx_pf IRQ, and Tx/Rx resources.
> 
> This can cause problems because the register reads will return
> potentially invalid values which may result in unknown driver behavior.
> 
> Begin the process of resetting using fm10k_prepare_for_reset(), much in
> the same way as the suspend and resume cycle does. This will attempt to
> shutdown as much as possible, in order to prevent possible issues.
> 
> A naive implementation for this has issues, because there are now
> multiple flows calling the reset logic and setting a reset bit. This
> would cause problems, because the "re-attach" routine might call
> fm10k_handle_reset() prior to the reset actually finishing. Instead,
> we'll add state bits to indicate which flow actually initiated the
> reset.
> 
> For the general reset flow, we'll assume that if someone else is
> resetting that we do not need to handle it at all, so it does not need
> its own state bit. For the suspend case, we will simply issue a warning
> indicating that we are attempting to recover from this case when
> resuming.
> 
> For the detached subtask, we'll simply refuse to re-attach until we've
> actually initiated a reset as part of that flow.
> 
> Finally, we'll stop attempting to manage the mailbox subtask when we're
> detached, since there's nothing we can do if we don't have a PCIe
> address.
> 
> Overall this produces a much cleaner shutdown and recovery cycle for
> a PCIe surprise remove event.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

