From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:29:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 13/18] fm10k: enable bus master
 after	every reset
In-Reply-To: <20160607230902.5457-14-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-14-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397F61@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 13/18] fm10k: enable bus master after every reset

If an FLR occurs, VF devices will be knocked out of bus master mode, and the driver will be unable to recover from the reset properly, resulting in malicious driver events and an infinite reset loop. In the normal case, the bus master mode will already be enabled and this call will essentially be a no-op. Since we're doing this every reset, it is possible we could remove the other calls to pci_set_master() but it seems not harmful to just leave them in place.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

