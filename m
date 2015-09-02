From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:05:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next rc2] fm10k: add support for
 extra	debug statistics
In-Reply-To: <1435797516-12187-1-git-send-email-jacob.e.keller@intel.com>
References: <1435797516-12187-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5418@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, July 1, 2015 5:39 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH net-next rc2] fm10k: add support for extra debug statistics

Add a private ethtool flag to enable display of these statistics, which are generally less useful. However, sometimes it can be useful for debugging purposes. The most useful portion is the ability to see what the PF thinks the VF mailboxes look like.

-rc2
* Add missing debug statistics from first pass

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
