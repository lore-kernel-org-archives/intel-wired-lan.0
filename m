From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:25:56 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: prevent RCU issues during
 AER	events
In-Reply-To: <1457718752-8678-2-git-send-email-jacob.e.keller@intel.com>
References: <1457718752-8678-1-git-send-email-jacob.e.keller@intel.com>
 <1457718752-8678-2-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273713DD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, March 11, 2016 9:53 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: prevent RCU issues during AER events

During an AER action response, we were calling fm10k_close without holding the rtnl_lock() which could lead to possible RCU warnings being produced due to 64bit stat updates among other causes. Similarly, we need rtnl_lock() around fm10k_open during fm10k_io_resume. Follow the same pattern elsewhere in the driver and protect the entire open/close sequence.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

