From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 30 Aug 2016 16:17:55 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: add support for Rx
 offloads on	one Geneve tunnel
In-Reply-To: <20160623205403.20327-3-jacob.e.keller@intel.com>
References: <20160623205403.20327-1-jacob.e.keller@intel.com>
 <20160623205403.20327-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273BF2EA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 23, 2016 1:54 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: add support for Rx offloads on one Geneve tunnel

Similar to how we handle VXLAN offload, enable support for a single Geneve tunnel.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


