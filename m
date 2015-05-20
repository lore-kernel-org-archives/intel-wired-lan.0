From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 20 May 2015 16:00:46 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Use a bus-global mutex to
 protect VPD operations
In-Reply-To: <555BDD14.2080807@redhat.com>
References: <20150519000037.56109.68356.stgit@mdrustad-wks.jf.intel.com>
 <555B78F7.60908@redhat.com> <20150519160158.00002cd6@unknown>
 <555BD029.7050803@redhat.com>
 <F47DC49C-CCC5-4693-8905-20ABCE6F5993@intel.com>
 <555BDD14.2080807@redhat.com>
Message-ID: <C73FDF83-62F7-47F4-905A-CD7D482F0709@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 6:02 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> My suspicion is that we have a number of bugs floating around out there like the Broadcom issue.  Specifically, one of the ones I found was that the r8169 seems to have a similar issue as called out in the email thread at http://permalink.gmane.org/gmane.linux.network/232260.  I'm wondering if we shouldn't add an initializer for the read/write functions that will go through and pull out the 3 or 4 headers from the VPD data needed to get the actual length.  Then it would lock down the VPD and save some serious time on reads since most devices don't have 32K of VPD to read.

That is interesting. I noticed that there are functions already present to find VPD tags. If the VPD were invalid, would this block its being read at all, or would it default to allow reading/writing anything? I don't know if there might be people using Linux to completely write the VPD area. Presumably your idea would prevent rewriting the VPD area to something larger.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150520/10677af5/attachment.asc>
