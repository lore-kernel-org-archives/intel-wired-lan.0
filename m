From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 1 Nov 2018 18:00:20 +0000
Subject: [Intel-wired-lan] [net-next 1/3] fm10k: fix SM mailbox full
 condition
In-Reply-To: <20181015191829.17115-2-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
 <20181015191829.17115-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E82A7589D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Monday, October 15, 2018 12:18 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
> Subject: [Intel-wired-lan] [net-next 1/3] fm10k: fix SM mailbox full condition
> 
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> 
> Current condition will always incorrectly report a full SM mailbox if an
> IES API application is not running. Due to this, the
> "fm10k_service_task" will be infinitely queued into the driver's
> workqueue. This, in turn, will cause a "kworker" thread to report 100%
> CPU utilization and might cause "soft lockup" events or system crashes.
> 
> To fix this issue, a new condition is added to determine if the SM
> mailbox is in the correct state of FM10K_STATE_OPEN before proceeding.
> In other words, an instance of the IES API must be running. If there is,
> the remainder of the flow stays the same which is to determine if the SM
> mailbox capacity has been exceeded or not and take appropriate action.
> 
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

