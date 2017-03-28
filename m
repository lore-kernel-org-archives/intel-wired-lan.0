From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 16:03:03 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: do not enqueue mailbox when
 host	not ready
In-Reply-To: <20170206222113.14170-1-jacob.e.keller@intel.com>
References: <20170206222113.14170-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E4914660C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, February 6, 2017 2:21 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH] fm10k: do not enqueue mailbox when host not ready

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Interfaces will reset whenever the TX mailbox FIFO has become full. This occurs more frequently whenever the IES API application is not running to process and clear the messages in the FIFO. Thus, this could lead to situations where the interface would enter an infinite reset loop. That
is: if the interface is trying to synchronize a huge number of unicast and multicast entries with the IES API application, the TX mailbox FIFO will become full and the interface resets. Once the interface exits reset, it'll try to synchronize the unicast and multicast entries again.
Ergo, this creates an infinite loop. Other actions such as multiple mulitcast mode or up/down transitions will fill the TX mailbox FIFO and induce the interface to reset. To correct these situations, check if the interface's "host_ready" flag is enabled before enqueuing any messages to the TX mailbox FIFO. This check will be conducted by a function call.
Lastly, this issue mainly affects the PF and, thus, the VF is exempt.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

