From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:19:35 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] fm10k: request reset when
 mbx->state	changes
In-Reply-To: <20161102234447.17181-3-jacob.e.keller@intel.com>
References: <20161102234447.17181-1-jacob.e.keller@intel.com>
 <20161102234447.17181-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F5280@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, November 2, 2016 4:45 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH 3/4] fm10k: request reset when mbx->state changes

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Multiple IES API resets can cause a race condition where the mailbox interrupt request bits can be cleared before being handled. This can leave certain mailbox messages from the PF to be untreated and the PF will enter in some inactive state. If this situation occurs, the IES API will initiate a mailbox version reset which, then, trigger a mailbox state change. Once this mailbox transition occurs (from OPEN to CONNECT state), a request for reset will be returned.

This ensures that PF will undergo a reset whenever IES API encounters an unknown global mailbox interrupt event or whenever the IES API terminates.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

