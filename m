From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 23 Dec 2016 20:50:33 +0000
Subject: [Intel-wired-lan] [PATCH V9 4/4] ixgbe: Implement support
	for	firmware-controlled PHYs
In-Reply-To: <148174213637.48405.14477495053235697150.stgit@mdrustad-wks.jf.intel.com>
References: <148174202018.48405.9935418150415224529.stgit@mdrustad-wks.jf.intel.com>
 <148174213637.48405.14477495053235697150.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491036CC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, December 14, 2016 11:02 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH V9 4/4] ixgbe: Implement support for firmware-controlled PHYs

Implement support for devices that have firmware-controlled PHYs.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Fixed some oversights primarily related to 10M support Changes in V3:
- Use the correct ops to blink the LED
Changes in V4:
- Actually get the right content into the patch Changes in V5:
- Properly indicate FC autoneg support
Changes in V6:
- Add missing thermal interrupt support
Changes in V8:
- Correct flow error in overtemp code
Changes in V9:
- Missed a subtlety in the logic resulting in double messages. Fixed.
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

