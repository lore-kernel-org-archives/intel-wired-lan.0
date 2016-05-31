From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 31 May 2016 18:07:11 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: fix incorrect index
 calculation	in fm10k_write_reta
In-Reply-To: <20160418224500.2680-1-jacob.e.keller@intel.com>
References: <20160418224500.2680-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2738EB12@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, April 18, 2016 3:45 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: fix incorrect index calculation in fm10k_write_reta

The index calculated when looping through the indir array passed to fm10k_write_reta was incorrectly calculated as the first part i needs to be multiplied by 4.

Fixes: 0cfea7a65738 ("fm10k: fix possible null pointer deref after kcalloc", 2016-04-13)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

