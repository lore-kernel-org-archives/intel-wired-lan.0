From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:11:54 +0000
Subject: [Intel-wired-lan] [rc3] fm10k: re-map all possible VF queues
 after	a VFLR
In-Reply-To: <1433892748-18136-1-git-send-email-jacob.e.keller@intel.com>
References: <1433892748-18136-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B54FF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 9, 2015 4:32 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [rc3] fm10k: re-map all possible VF queues after a VFLR

From: Keller Jacob <jacob.e.keller@intel.com>

During initialization, the VF counts its rings by walking the TQDLOC registers. This works only if the TQMAP/RQMAP registers are set to map all of the out-of-bound rings back to the first one. This allows the VF to cleanly detect when it has run out of queues. Update the PF code so that it resets the empty TQMAP/RQMAP registers post-VFLR to prevent innocent VF drivers from triggering malicious driver events.

-rc3
* Use corrected index, instead of 1

Signed-off-by: Matthew Vick <matthew.vick@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
