From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 22 Aug 2016 22:29:50 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: don't try to stop queues if
 we've	lost hw_addr
In-Reply-To: <20160623205403.20327-1-jacob.e.keller@intel.com>
References: <20160623205403.20327-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B82AA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 23, 2016 1:54 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: don't try to stop queues if we've lost hw_addr

In the event of a surprise remove, we expect the driver to go down, which includes calling .stop_hw(). However, this function will return an error because the queues won't appear to cleanly disable. Prevent this and avoid the unnecessary checks by just returning when
FM10K_REMOVED(hw->hw_addr) is true.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


