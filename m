From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 9 Nov 2015 23:06:20 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't
	initialize	fm10k_workqueue at global level
In-Reply-To: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
References: <1446579302-11494-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27232C5C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, November 3, 2015 11:35 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2] fm10k: don't initialize fm10k_workqueue at global level

From: Bruce Allan <bruce.w.allan@intel.com>

Cleans up checkpatch GLOBAL_INITIALIZERS error

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

