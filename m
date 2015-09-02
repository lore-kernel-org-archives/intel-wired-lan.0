From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:13:52 +0000
Subject: [Intel-wired-lan] [rc2 14/15] fm10k: remove err_no reference
	in	fm10k_mbx.c
In-Reply-To: <1433374272-6684-15-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
 <1433374272-6684-15-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5543@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 3, 2015 4:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [rc2 14/15] fm10k: remove err_no reference in fm10k_mbx.c

The reference to err_no was left around after a previous code refactor.
We never use the value, and it doesn't seem to be used in side a hidden macro reference. Discovered via cppcheck.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
