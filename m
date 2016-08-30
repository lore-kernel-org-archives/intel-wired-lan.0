From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 30 Aug 2016 16:16:26 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: rework vxlan_port
	offload	before adding geneve support
In-Reply-To: <20160623205403.20327-2-jacob.e.keller@intel.com>
References: <20160623205403.20327-1-jacob.e.keller@intel.com>
 <20160623205403.20327-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273BF2CD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 23, 2016 1:54 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: rework vxlan_port offload before adding geneve support

In preparation for adding Geneve Rx offload support, refactor the current VXLAN offload flow to be a bit more generic so that it will be easier to add the new Geneve code. The fm10k hardware supports one VXLAN and one Geneve tunnel, so we will eventually treat the VXLAN and Geneve tunnels identically. To this end, factor out the code that handles the current list so that we can use the generic flow for both tunnels in the next patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

