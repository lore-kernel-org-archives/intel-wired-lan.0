From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:18:37 +0000
Subject: [Intel-wired-lan] [PATCH v3 14/16] fm10k: introduce a message
 queue	for MAC/VLAN messages
In-Reply-To: <20170710202319.22110-14-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
 <20170710202319.22110-14-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF67A0@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 14/16] fm10k: introduce a message queue
> for MAC/VLAN messages
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

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

