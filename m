From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:24:45 +0000
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: prevent RCU issues during
 AER	events
In-Reply-To: <1454611679-17424-6-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
 <1454611679-17424-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A90D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, February 4, 2016 10:48 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: prevent RCU issues during AER events

During an AER action response, we were calling fm10k_close without holding the rtnl_lock() which could lead to possible RCU warnings being produced due to 64bit stat updates among other causes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

