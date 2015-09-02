From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:08:29 +0000
Subject: [Intel-wired-lan] [rc2 05/15] fm10k: add call
	to	fm10k_clean_all_rx_rings in fm10k_down
In-Reply-To: <1433374272-6684-6-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
 <1433374272-6684-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5479@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 3, 2015 4:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [rc2 05/15] fm10k: add call to fm10k_clean_all_rx_rings in fm10k_down

This prevents a memory leak in fm10k_set_ringparams. The leak occurs because we go down, change ring parameters, and then come up. However, fm10k_down on its own is not clearing the Rx rings. Since fm10k_up assumes the rings are clean we basically drop the buffers and leak a bunch of memory. Eventually we hit dirty page faults and reboot the system. This issue does not occur elsewhere because other flows that involve fm10k_down go through fm10k_close which immediately called fm10k_free_all_rx_resources which properly cleans the rings.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
