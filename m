From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 23 Jun 2016 23:30:30 +0000
Subject: [Intel-wired-lan] [PATCH v2 15/18] fm10k:
	implement	request_lport_map pointer
In-Reply-To: <20160607230902.5457-16-jacob.e.keller@intel.com>
References: <20160607230902.5457-1-jacob.e.keller@intel.com>
 <20160607230902.5457-16-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27397F8D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 7, 2016 4:09 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 15/18] fm10k: implement request_lport_map pointer

If the fm10k interface is brought up, but the switch manager software is not running, the driver will continuously request the lport map every few seconds in the base driver watchdog routine. Eventually after several minutes the switch mailbox Tx fifo will fill up and the mailbox will timeout, resulting in a reset. This reset will appear as if for no reason, and occurs regularly every few minutes until the switch manager software is loaded.

Prevent this from happening by only requesting the lport map after we've verified the switch mailbox is tx_ready. In order to simplify code logic and reduce code duplication, implement this as a new function pointer "mac.ops.request_lport_map" which the VF will not implement. Otherwise, we have to duplicate the tx_ready check outside of fm10k_get_host_state_generic, or re-implement most of fm10k_get_host_state_generic in the pf version.

The resulting code is simpler and easier to understand, and prevents the PF from continuously requesting lport map and filling the Tx fifo of a switch mailbox that isn't ready.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>


