From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:33:35 +0000
Subject: [Intel-wired-lan] [PATCH v1 2/9] fm10k: Fix multicast mode
	sync	issues
In-Reply-To: <1459552659-22959-3-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371439@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Kwan, Ngai-mint <ngai-mint.kwan@intel.com>
Subject: [Intel-wired-lan] [PATCH v1 2/9] fm10k: Fix multicast mode sync issues

From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>

Multicast mode checking is no longer a requirement to perform unicast and multicast address syncs. Specifically, a device operating in promiscuous and/or all multicast mode is not excluded. The issue occurs when the netdev is pre-configured to either multicast mode and is enabled for the first time. The multicast-group table in the Switch Manager will be missing obvious multicast entries associated to this netdev.

Changes were also made to disallow unicast and multicast syncs with VLAN 0. The Switch Manager considers VLAN 0 to be an invalid entry.
Requests with VLAN 0 by the netdev are only generated when the driver is freshly installed and the default VID is not set.

Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

