From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 28 Oct 2015 22:40:23 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
 function	fm10k_resume
In-Reply-To: <1445098842-28260-1-git-send-email-xerofoify@gmail.com>
References: <1445098842-28260-1-git-send-email-xerofoify@gmail.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221EC0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Nicholas Krause
Sent: Saturday, October 17, 2015 9:21 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function fm10k_resume

This fixes error handling to proper check if the call to the function fm10k_mbx_request_irq has failed by returning a error code and if so return immediately to the caller of fm10k_resume to properly signal a failure has occurred when accepting to resume this network

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---

Tested-by: Krishneil SIngh <krishneil.k.singh@intel.com>

