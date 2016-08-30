From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 30 Aug 2016 16:20:00 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: wrap long line for
 alloc_workqueue
In-Reply-To: <20160825211539.3853-1-jacob.e.keller@intel.com>
References: <20160825211539.3853-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273BF32B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, August 25, 2016 2:16 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: wrap long line for alloc_workqueue

Trivial change here to cleanup a checkpatch.pl warning that got introduced when changing to alloc_workqueue.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

