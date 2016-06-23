From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:19:57 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/18] fm10k: don't stop reset due
 to	FM10K_ERR_REQUESTS_PENDING
In-Reply-To: <20160607230902.5457-4-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-4-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397E93@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 03/18] fm10k: don't stop reset due to FM10K_ERR_REQUESTS_PENDING

Don't report FM10K_ERR_REQUESTS_PENDING when we fail to disable queues within the timeout. This can occur due to a hardware Tx hang, or when the switch ethernet fabric is resetting while we are transmitting traffic. It can sometimes take up to 500ms before the Tx DMA engine gives up. Instead, just skip the DMA engine check and perform a data-path reset anyways. Add a statistic counter to keep track of the number of resets occurring while we have pending DMA on the rings.

In order to prevent having to re-assign err to 0, re-order the last few items of the reset_hw_pf function so that we don't perform "return err" at the end.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

