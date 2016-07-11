From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 11 Jul 2016 19:24:49 +0000
Subject: [Intel-wired-lan] [PATCH v2 01/18] fm10k: prevent multiple
 threads	updating statistics
In-Reply-To: <20160607230902.5457-2-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273A187D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 01/18] fm10k: prevent multiple threads updating statistics

Also prevent updating stats while the interface is down. If we're already updating stats, just return doing nothing. When we take the device down, block stat updates until we come back up. This ensures that we avoid tearing down rings when we're updating statistics, and prevents updating statistics until we're up.

We can't re-use the __FM10K_DOWN for this because it wouldn't prevent multiple threads from accessing statistics. Neither does it prevent the case where we start updating stats and then start going down in another thread.

The fm10k_get_stats64 is except from this, because it has a completely different flow which does not suffer from the same issues as fm10k_update_stats might.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

