From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 28 Mar 2017 16:01:39 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] fm10k: disable receive queue
	when	configuring ring
In-Reply-To: <20170112235942.5767-5-jacob.e.keller@intel.com>
References: <20170112235942.5767-1-jacob.e.keller@intel.com>
 <20170112235942.5767-5-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491465F4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, January 12, 2017 4:00 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH 5/5] fm10k: disable receive queue when configuring ring

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Write to RXQCTL register to disable the receive queue when configuring the RX ring.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
---
Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

