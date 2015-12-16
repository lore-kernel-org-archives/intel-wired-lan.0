From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 16 Dec 2015 22:51:48 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: IS_ENABLED() is not
 appropriate for boolean kconfig option
In-Reply-To: <20151209012049.134015.46680.stgit@bwallan-cwp1.jf.intel.com>
References: <20151209012049.134015.46680.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27313FD3@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Tuesday, December 8, 2015 5:21 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] fm10k: IS_ENABLED() is not appropriate for boolean kconfig option

Tri-states need 'if IS_ENABLED()', booleans should use 'ifdef'.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com> 


