From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:11:22 +0000
Subject: [Intel-wired-lan] [rc2 10/15] fm10k: force LPORT delete
	when	updating VLAN or MAC address
In-Reply-To: <1433374272-6684-11-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
 <1433374272-6684-11-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B54E8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 3, 2015 4:31 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [rc2 10/15] fm10k: force LPORT delete when updating VLAN or MAC address

Currently, we don't notify the switch at all when the PF administratively sets a new VLAN or MAC address. This causes the old addresses to remain valid on the switch table. Since the PF is overriding any configuration done directly by the VF, we choose to simply re-create the LPORT for the VF. This does mean that all rules for the VF will be dropped when we set something directly via the PF, but it prevents some weird issues where the MAC/VLAN table retains some stale configuration.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
