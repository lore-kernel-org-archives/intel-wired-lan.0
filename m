From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 21 Jul 2015 00:07:06 +0000
Subject: [Intel-wired-lan] [PATCH 0/3] ixgbe: Add support for X550EM
 devices	with SFPs
In-Reply-To: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
References: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <6FFB6821-C0B7-4BA3-B583-61401FBC1A18@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jul 17, 2015, at 3:22 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> 
> The following patches add remaining bits of support for X550EM
> devices with SFPs. The last patch adds the device ID.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> ---
> 
> Mark D Rustad (3):
>      ixgbe: Accept SFP not present errors on all devices
>      ixgbe: Add X550EM support for SFP insertion interrupt
>      ixgbe: Add new X550EM SFP+ device ID

I found some missing pieces and other issues with this series, so I will be spinning a new series to replace these.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150721/54c9458e/attachment.asc>
