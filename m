From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 1 May 2018 21:25:44 +0000
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: don't protect
 fm10k_queue_mac_request by fm10k_host_mbx_ready
In-Reply-To: <20180412181559.4343-6-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
 <20180412181559.4343-6-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E8294D528@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Jacob Keller
> Sent: Thursday, April 12, 2018 11:16 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: don't protect
> fm10k_queue_mac_request by fm10k_host_mbx_ready
> 
> We don't actually need to check if the host mbx is ready when queuing
> MAC requests, because these are not handled by a special queue which
> queues up requests until the mailbox is capable of handling them.
> 
> Pull these requests outside the fm10k_host_mbx_ready() check, as it is
> not necessary.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

