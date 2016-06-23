From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:23:12 +0000
Subject: [Intel-wired-lan] [PATCH v2 06/18] fm10k: only warn when
 stop_hw	fails with FM10K_ERR_REQUESTS_PENDING
In-Reply-To: <20160607230902.5457-7-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-7-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397ED0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 06/18] fm10k: only warn when stop_hw fails with FM10K_ERR_REQUESTS_PENDING

When stop_hw() routine fails with FM10K_ERR_REQUESTS_PENDING, this indicates that the Tx or Rx queues did not shutdown within the time limit. Print a more suitable message at the dev_info level instead of dev_err.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


