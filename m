From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 23 Oct 2015 21:31:22 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Update PTP to support
 X550EM_x	devices
In-Reply-To: <20151023212337.16087.44470.stgit@mdrustad-wks.jf.intel.com>
References: <20151023212337.16087.44470.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <80D5D35F-8EFD-476F-9898-C9D2C01EB97B@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sorry for the missed changelog. This V2 fixes some formatting issues and also adds some code that was overlooked, specifically the static inline ixgbe_ptp_rx_hwtstamp.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151023/e74f5310/attachment.asc>
