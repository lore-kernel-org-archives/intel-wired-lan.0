From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:25:55 +0000
Subject: [Intel-wired-lan] [PATCH v2 09/18] fm10k: implement
 prepare_suspend	and handle_resume
In-Reply-To: <20160607230902.5457-10-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-10-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397F0F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 09/18] fm10k: implement prepare_suspend and handle_resume

Implement fm10k_prepare_suspend and fm10k_handle_resume functions which abstract around the now existing fm10k_prepare_for_reset and fm10k_handle_reset. The new functions also handle stopping the service task, which is something that the original re-init flow does not need.

Every other location that does a suspend/resume type flow is expected to use these functions, because otherwise they may have conflicts with the running watchdog routines. This also has the effect of preventing possible surprise remove events during handling of FLR events and PCIe errors.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

