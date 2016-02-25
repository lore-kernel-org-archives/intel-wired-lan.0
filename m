From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:23:04 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: print error message
	when	stop_hw fails
In-Reply-To: <1454611679-17424-4-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
 <1454611679-17424-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A8E4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, February 4, 2016 10:48 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: print error message when stop_hw fails

fm10k_stop_hw_generic calls fm10k_disable_queues_generic, which may return an error code indicating that the queues were not stopped within the time limit. Notify the user by displaying a message in the kernel message ring, in a similar way to how we notify the user when reset_hw fails. There isn't much we can do to recover from this error, so currently nothing else is done.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>
