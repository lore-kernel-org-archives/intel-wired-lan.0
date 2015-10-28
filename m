From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 28 Oct 2015 00:44:06 +0000
Subject: [Intel-wired-lan] [next-queue v5 05/17] fm10k: reinitialize
 queuing	scheme after calling init_hw
In-Reply-To: <1445018231-3196-5-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-5-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27221952@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, October 16, 2015 10:57 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v5 05/17] fm10k: reinitialize queuing scheme after calling init_hw

The init_hw function may fail, and in the case of VFs, it might change the number of maximum queues available. Thus, for every flow which checks init_hw, we need to ensure that we clear the queue scheme before, and initialize it after. The fm10k_io_slot_reset path will end up triggering a reset so fm10k_reinit needs this change. The fm10k_io_error_detected and fm10k_io_resume also need to properly clear and reinitialize the queue scheme.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

