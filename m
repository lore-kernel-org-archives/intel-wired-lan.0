From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 27 May 2015 19:11:05 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
	protect VPD operations
In-Reply-To: <20150527172741.GX32152@google.com>
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
 <20150527172741.GX32152@google.com>
Message-ID: <151DE2D4-7D19-48B1-8317-9470F03B400D@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 27, 2015, at 10:27 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> It sounds like there are real problems here that would be fixed by changing
> the mutex strategy and limiting VPD read lengths, but that we don't quite
> have consensus on how to solve them yet.

I have a new pair of patches that I am getting internal feedback on. I
will be on vacation starting tomorrow and won't be back until Tuesday, so
I think it best to send them when I get back so that I will be available
to respond. I could be convinced to send them now.

> VPD is a bit of a tar pit.

It sure is.

> We've talked about limiting VPD read length
> before (see links below), which requires interpreting the VPD contents
> (just the tags & sizes) the kernel.  I think I'm OK with doing that,
> provided we should audit existing users and make sure we don't break them.
> 
> http://lkml.kernel.org/r/c67cd7f4-8d8f-48fc-a63c-dbdafde873a2 at CMEXHTCAS1.ad.emulex.com
> http://lkml.kernel.org/r/1f6d7b6c-7189-4fe3-926b-42609724cab9 at CMEXHTCAS2.ad.emulex.com
> 
> I'd also like to include specifics, e.g., bugzillas with complete dmesg and
> lspci information, for the problems we're fixing.

The issue I am addressing is for when the VPD Address/F and Data registers
are shared across multiple functions. My latest patch addresses this by
always performing the access through function 0. I added a dev_flags bit
to indicate when this should be done, so only devices that have a quirk
that sets that bit will get that treatment.

The patch I have still doesn't address the issue for direct-assigned
devices. I have no answer to that, but will point out that most guests
seem to use virtual machines that don't support extended config space
anyway. Only those that do support extended config space and access VPD
could be a source of trouble.

I have to say that I haven't actually reproduced the failure, but given
the design of the hardware it is clear that somehow a common mutex needs
to protect those shared registers.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150527/401fc125/attachment.asc>
