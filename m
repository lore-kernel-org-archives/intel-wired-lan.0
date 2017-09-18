From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:24:54 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: reschedule service event
 if we	stall the PF<->SM mailbox
In-Reply-To: <20170308235543.16537-2-jacob.e.keller@intel.com>
References: <20170308235543.16537-1-jacob.e.keller@intel.com>
 <20170308235543.16537-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF6835@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, March 8, 2017 3:56 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: reschedule service event if we
> stall the PF<->SM mailbox
> 
> When we are handling PF<->VF mailbox messages, it is possible that the
> VF will send us so many messages that the PF<->SM FIFO will fill up. In
> this case, we stop the loop and wait until the service event is
> rescheduled.
> 
> Normally this should happen due to an interrupt. But it is possible that
> we don't get another interrupt for a while and it isn't until the
> service timer actually reschedules us. Instead, simply reschedule
> immediately which will cause the service event to be run again as soon
> as we exit.
> 
> This ensures that we promptly handle all of the PF<->VF messages with
> minimal delay, while still giving time for the SM mailbox to drain.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

