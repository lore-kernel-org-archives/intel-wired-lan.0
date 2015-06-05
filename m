From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 5 Jun 2015 21:59:20 +0000
Subject: [Intel-wired-lan] [PATCH V3 0/2] pci: Provide a flag to access
 VPD through function 0
In-Reply-To: <20150603184445.109080.36387.stgit@mdrustad-wks.jf.intel.com>
References: <20150603184445.109080.36387.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <051B68B4-3E77-4EB0-B9FE-8523631884A2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 3, 2015, at 11:46 AM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> 
> Many multi-function devices provide shared registers in extended
> config space for accessing VPD. The behavior of these registers
> means that the state must be tracked and access locked correctly
> for accesses not to hang or worse. One way to meet these needs is
> to always perform the accesses through function 0, thereby using
> the state tracking and mutex that already exists.
> 
> To provide this behavior, add a dev_flags bit to indicate that this
> should be done. This bit can then be set for any non-zero function
> that needs to redirect such VPD access to function 0. Do not set
> this bit on the zero function or there will be an infinite recursion.
> 
> The second patch uses this new flag to invoke this behavior on all
> multi-function Intel Ethernet devices.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> ---
> Changes in V2:
> - Corrected a spelling error in a log message
> - Added checks to see that the referenced function 0 is reasonable
> Changes in V3:
> - Don't leak a device reference
> - Check that function 0 has VPD
> - Make a helper for the function 0 checks
> - Moved a multifunction check to the quirk patch

So does this series look acceptable now? I think I addressed the issues that Alex raised. Can these also be considered for -stable?

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150605/fb249164/attachment.asc>
