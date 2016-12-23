From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 23 Dec 2016 20:46:43 +0000
Subject: [Intel-wired-lan] [PATCH V9 1/4] ixgbe: Fix issues with
	EEPROM	access
In-Reply-To: <148174212080.48405.5004281387054679857.stgit@mdrustad-wks.jf.intel.com>
References: <148174202018.48405.9935418150415224529.stgit@mdrustad-wks.jf.intel.com>
 <148174212080.48405.5004281387054679857.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E49103684@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, December 14, 2016 11:02 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH V9 1/4] ixgbe: Fix issues with EEPROM access

There are two problems with EEPROM access. One is that it needs to hold the semaphore until the entire response is read or else the response can be corrupted by other firmware accesses. The second problem is that acquiring and releasing the semaphore is slow, so it should be taken and released once when multiple EEPROM accesses will be done.

Both of these issues can be solved by adding a new function, ixgbe_hic_unlocked, to issue firmware commands that will assume that the caller has acquired the needed semaphore.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
