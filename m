From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 16:50:34 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: ensure we process SM mbx
 when	processing VF mbx
In-Reply-To: <20170308235543.16537-1-jacob.e.keller@intel.com>
References: <20170308235543.16537-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF6588@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: ensure we process SM mbx when
> processing VF mbx
> 
> When we process VF mailboxes, the driver is likely going to also queue
> up messages to the switch manager. This process merely queues up the
> FIFO, but doesn't actually begin the transmission process. Because we
> hold the mailbox lock during this VF processing, the PF<->SM mailbox is
> not getting processed at this time. Ensure that we actually process the
> PF<->SM mailbox in between each PF<->VF mailbox.
> 
> This should ensure prompt transmission of the messages queued up after
> each VF message is received and handled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>
