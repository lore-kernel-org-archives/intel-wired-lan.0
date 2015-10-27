From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:23:12 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
 function	fm10k_setup_tc
In-Reply-To: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
References: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221461@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Nicholas Krause
Sent: Tuesday, October 20, 2015 2:05 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function fm10k_setup_tc

This fixes error handling in the function fm10k_setup_tc to properly check if the call to the function fm10k_open has failed by returning a error and if so return immediately to the caller of the function fm10k_setup_tc to properly signal this non recoverable failure.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


