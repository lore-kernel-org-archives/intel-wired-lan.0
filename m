From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:24:00 +0000
Subject: [Intel-wired-lan] [PATCH v2 07/18] fm10k: wait for queues to
 drain	if stop_hw() fails once
In-Reply-To: <20160607230902.5457-8-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-8-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397EE5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 07/18] fm10k: wait for queues to drain if stop_hw() fails once

It turns out that sometimes during a reset the Tx queues will be temporarily stuck longer than .stop_hw() expects. Work around this issue by attempting to .stop_hw() first. If it tails, wait a number of attempts until the Tx queues appear to be drained. After this, attempt
stop_hw() again. This ensures that we avoid waiting if we don't need to, such as during the first initialization of a VF, and give the proper amount of time necessary to recover from most situations. It is possible that the hardware is actually stuck. For PFs, this is usually fixed by a datapath reset. Unfortunately the VF cannot request a similar reset for itself.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


