From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 23 Mar 2016 16:08:38 +0000
Subject: [Intel-wired-lan] [PATCH V2 0/7] ixgbe: Add initial support for
 a	new ixgbe MAC
In-Reply-To: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
References: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <600B5A94-F0F3-499C-8CDF-E8A962AC0A8D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jeff,

Mark D Rustad <mark.d.rustad@intel.com> wrote:

> The following patches add initial support for a new ixgbe MAC type.
> The initial interface supported is a native SFP+ interface.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Added a missing check to set SFP detection interrupt mask

I wanted to let you know that I am working on a replacement patch series  
for this series as well as the other 6-patch series. The new series will  
incorporate the feedback you gave me, fix a crashing bug and provide more  
interfaces all in the new single series. I have some more work to do on it,  
but it should be ready some time this week.

> ---
>
> Mark D Rustad (7):
>       ixgbe: Add definitions for new 10G MAC
>       ixgbe: Add support for phy token firmware command
>       ixgbe: Add new semaphore method for a new MAC
>       ixgbe: Use method pointer to access IOSF devices
>       ixgbe: Provide for use of firmware to access IOSF registers
>       ixgbe: Add support for new 10G MAC type
>       ixgbe: Add some new device IDs for new 10G MAC

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160323/5774cdf7/attachment.asc>
