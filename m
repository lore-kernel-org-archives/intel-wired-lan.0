From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:31:50 +0000
Subject: [Intel-wired-lan] [PATCH v2 17/18] fm10k: return proper error
 code	when pci_enable_msix_range fails
In-Reply-To: <20160607230902.5457-18-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-18-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397FB5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 17/18] fm10k: return proper error code when pci_enable_msix_range fails

The pci_enable_msix_range() function returns a positive value of the number of allocated vectors if it succeeds. On failure it returns a negative error code. Return this code properly so that the error message printed by the driver will show the actual error code instead of being masked by -ENOMEM.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

