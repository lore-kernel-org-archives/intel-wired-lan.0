From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 16 Oct 2015 18:05:22 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix spoofed packets
	with	random MAC
In-Reply-To: <20151012175600.13894.26059.stgit@localhost6.localdomain6>
References: <20151012175551.13894.37989.stgit@localhost6.localdomain6>
 <20151012175600.13894.26059.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2721D1BC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Monday, October 12, 2015 10:56 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbevf: fix spoofed packets with random MAC

If ixgbevf is loaded while the corresponding PF interface is down and the driver assigns a random MAC address, that address can be overwritten with the value of hw->mac.perm_addr, which would be 0 at that point.

To avoid this case we init hw->mac.perm_addr to the randomly generated address and do not set it unless we receive ACK from ixgbe.

Reported-by: John Greene <jogreene@redhat.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
Tested-By: Krishneil Singh <Krishneil.k.singh@intel.com>


