From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 3 Nov 2015 02:34:18 +0000
Subject: [Intel-wired-lan] [next-queue 1/6] fm10k: use ether_addr_copy
 to	copy MAC address
In-Reply-To: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
References: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27223191@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, October 26, 2015 4:32 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue 1/6] fm10k: use ether_addr_copy to copy MAC address

Use the ether_addr_copy function instead of copying byte-by-byte in a for-loop by hand.

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

