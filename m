From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Feb 2016 20:20:05 +0000
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: prevent null
	pointer	dereference of msix_entries table
In-Reply-To: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2734A8BB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, February 4, 2016 10:48 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: prevent null pointer dereference of msix_entries table

According to the C standard dereferencing a variable before it is checked invokes undefined behavior, and thus compilers are free to assume the check for NULL isn't necessary. Prevent this by re-ordering the NULL check of msix_entries in fm10k_free_mbx_irq.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>
