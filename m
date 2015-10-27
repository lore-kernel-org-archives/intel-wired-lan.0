From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:10:21 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
 function	fm10k_setup_tc for certain function calls
In-Reply-To: <1444406000-4446-1-git-send-email-xerofoify@gmail.com>
References: <1444406000-4446-1-git-send-email-xerofoify@gmail.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E272213B0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Nicholas Krause
Sent: Friday, October 9, 2015 8:53 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the function fm10k_setup_tc for certain function calls

This fixes the function fm10k_setup_tc to propley check if the calls to either the function fm10k_init_queueing_scheme or the function fm10k_mbx_request_irq fail by returning a error code to signal that the call to either function has failed. Furthermore if this arises exit immediately from the function fm10k_setup_tc by returning the returned error code from the failed function call to signal to the caller that setting up the tc on the device has failed and the caller needs to handle this failed setup.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

