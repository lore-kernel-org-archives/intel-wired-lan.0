From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:09:05 +0000
Subject: [Intel-wired-lan] [PATCH rc2] fm10k: use an unsigned int for i
 in	ethtool_get_strings
In-Reply-To: <1434487151-2735-1-git-send-email-jacob.e.keller@intel.com>
References: <1434487151-2735-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5489@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 16, 2015 1:39 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH rc2] fm10k: use an unsigned int for i in ethtool_get_strings

The value will never be negative, and we use the %u print format. Thus, use unsigned int for the loop counter. Issue found using cppcheck.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
