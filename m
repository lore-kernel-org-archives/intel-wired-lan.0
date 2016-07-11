From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 11 Jul 2016 19:23:22 +0000
Subject: [Intel-wired-lan] [PATCH v1 01/18] fm10k: no need to continue
 in	fm10k_down if __FM10K_DOWN already set
In-Reply-To: <20160603224228.10192-2-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
 <20160603224228.10192-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273A184E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, June 3, 2016 3:42 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 01/18] fm10k: no need to continue in fm10k_down if __FM10K_DOWN already set

Return early from fm10k_down() when we are already down, since that means another thread is either already finished or has started going down, so shouldn't conflict with them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

