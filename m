From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 22 Aug 2016 22:48:11 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] fm10k: don't re-map queues
 when a	mailbox message suffices
In-Reply-To: <20160809000819.27627-1-jacob.e.keller@intel.com>
References: <20160809000819.27627-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273B82FB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, August 8, 2016 5:08 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v2 2/2] fm10k: don't re-map queues when a mailbox message suffices

When the PF assigns a new MAC address to a VF it uses the base address registers to store the MAC address. This allows a VF which loads after this setup the ability to get the initial address without having to wait for a mailbox message. Unfortunately to do this, the PF must take queue ownership away from the VF, which can cause fault errors when there is already an active VF driver.

This queue ownership assignment causes race condition between the PF and the VF such that potentially a VF can cause FUM fault errors due to normal PF/VF driver behavior.

It is not safe to simply allow the PF to write the base address registers without taking queue ownership back as the PF must also disable the queues, and this would impact active VF use. The current code is safe because the queue ownership will prevent the VF from actually writing but does trigger the FUM fault.

We can do better by simply avoiding the register write process when a mailbox message suffices. If the message can be sent over the mailbox, then we will not perform the queue ownership assignment and we won't update the base address to be the same as the MAC address.

We do still have to write the TXQCTL registers in order to update the VID of the queue. This is necessary because the TXQCTL register is read-only from the VF, and thus the VF cannot do this for itself. This register does not need to wait for the Tx queue to be disabled and is safe for the PF to write during normal VF operation, so we move this write to the top of the function above the mailbox message. Without this, the TXQCTL register would be misconfigured and cause the VF to Tx hang.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

