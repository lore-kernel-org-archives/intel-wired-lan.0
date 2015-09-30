From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 30 Sep 2015 19:08:09 +0000
Subject: [Intel-wired-lan] [next-queue] fm10k: use snprintf() instead
	of	sprintf() to avoid buffer overflow
In-Reply-To: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
References: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271CEB8F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, August 24, 2015 5:02 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue] fm10k: use snprintf() instead of sprintf() to avoid buffer overflow

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>


