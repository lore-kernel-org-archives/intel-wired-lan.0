From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 3 Nov 2015 20:47:35 +0000
Subject: [Intel-wired-lan] [next PATCH 2/5] fm10k: Cleanup exception
 handling for mailbox interrupt
In-Reply-To: <20151027235918.30048.41769.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235918.30048.41769.stgit@localhost.localdomain>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27225E6D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Alexander Duyck
Sent: Tuesday, October 27, 2015 4:59 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH 2/5] fm10k: Cleanup exception handling for mailbox interrupt

This patch addresses two issues.

First is the fact that the fm10k_mbx_free_irq was assuming msix_entries was valid and that will not always be the case.  As such we need to add a check for if it is NULL.

Second is the fact that we weren't freeing the IRQ if the mailbox API returned an error on trying to connect.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


