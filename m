From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:35:00 +0000
Subject: [Intel-wired-lan] [PATCH v1 3/9] fm10k: correctly handle
 LPORT_MAP	error
In-Reply-To: <1459552659-22959-4-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371453@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 3/9] fm10k: correctly handle LPORT_MAP error

Currently, any error responses from the switch manager after an LPORT_MAP request are silently ignored. At most the mailbox message will be reported as an error. This can result in unexpected behavior when the switch manager has configured a port with zero bandwidth. Add support for reading the fm10k_swapi_error structure from LPORT_MAP responses.

If the message contains the necessary TLV and has a non-zero error code, report link down, clear the dglort_map, and delay the next get_host_state call by a reasonable delay. Also log an error message indicating that the LPORT_MAP request failed.

The delay ensures preventing an interrupt storm on the switch manager, and reduces the number of mailbox messages we send in this scenario drastically.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

