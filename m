From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 2 Feb 2016 22:27:55 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: use ether_addr_copy
 to	copy MAC address
In-Reply-To: <20151229020030.2327.78167.stgit@bwallan-smackover2.jf.intel.com>
References: <20151229020030.2327.78167.stgit@bwallan-smackover2.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27339DAA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bruce Allan
Sent: Monday, December 28, 2015 6:01 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: use ether_addr_copy to copy MAC address

Cleanup the remaining instances of using memcpy() instead of the preferred ether_addr_copy().

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



