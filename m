From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:10:13 +0000
Subject: [Intel-wired-lan] [PATCH rc2] fm10k: trivial fixup message
 style to	include a colon
In-Reply-To: <1434487232-3825-1-git-send-email-jacob.e.keller@intel.com>
References: <1434487232-3825-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B54B9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 16, 2015 1:41 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH rc2] fm10k: trivial fixup message style to include a colon

Also use %d for error values, since printing in hexadecimal is probably not helpful.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
