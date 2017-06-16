From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 16 Jun 2017 22:45:32 +0000
Subject: [Intel-wired-lan] [PATCH 14/15] fm10k: introduce a message
 queue for MAC/VLAN messages
In-Reply-To: <20170601224051.6106-15-jacob.e.keller@intel.com>
References: <20170601224051.6106-1-jacob.e.keller@intel.com>
 <20170601224051.6106-15-jacob.e.keller@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58829C74F0@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Keller, Jacob E
> Sent: Thursday, June 01, 2017 3:41 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [PATCH 14/15] fm10k: introduce a message queue for MAC/VLAN
> messages
> 
> Under some circumstances, when dealing with a large number of MAC
> address or VLAN updates at once, the fm10k driver, particularly the VFs
> can overload the mailbox with too many messages at once.
> 
> This results in a mailbox timeout, which causes the driver to initiate
> a reset. During the reset, we re-send all the same messages that
> originally caused the timeout. This results in a cycle of resets each
> triggering a future reset.
> 
> To fix or avoid this, we introduce a workqueue item which monitors
> a queue of MAC and VLAN requests. These requests are queued to the end
> of the list, and we process as a FIFO periodically.
> 
> Initially we only handle requests for the netdev, but we do handle
> unicast MAC addresses, multicast MAC addresses, and update VLAN
> requests.
> 
> A future patch will add support to use this queue for handling MAC
> update requests from the VF<->PF mailbox.
> 
> The MAC/VLAN work item will keep checking to make sure that each request
> does not overflow the mailbox and cause a timeout. If it might, then the
> work item will reschedule itself a short time later. This avoids any
> reset cycle, since we never send the message if the mailbox is not
> ready.
> 
> As an alternative, we tried increasing the mailbox message FIFO, but
> this just delays the problem and results in needless memory waste on the
> system. Our new message queue is dynamically allocated so only uses as
> much memory as it needs. Additionally, it need not be contiguous like
> the Tx and Rx FIFOs.
> 
> Note that this patch chose to only create a queue for MAC and VLAN
> messages, since these are the only messages sent in a large enough
> volume to cause the reset loop. Other messages are very unlikely to
> overflow the mailbox Tx fifo so easily.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Validation found a bug in this patch. I'll be sending a v2 (of only this patch) that should apply in-place of the current version on your queue.

Regards,
Jake

