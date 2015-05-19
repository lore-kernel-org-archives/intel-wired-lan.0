From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 May 2015 22:43:39 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Limit VPD reads for all Intel
 Ethernet devices
In-Reply-To: <555BA850.1090901@gmail.com>
References: <20150519000042.56109.69779.stgit@mdrustad-wks.jf.intel.com>
 <555B5CBF.1090902@redhat.com>
 <4AD84211-965C-4F0B-A7F4-3E6CCE6567E3@intel.com>
 <555B77E5.5060006@redhat.com>
 <99014381-25AB-416D-8E09-C431B5CD5A6C@intel.com>
 <555B9F74.3040004@redhat.com>
 <DA06AAB6-CE9B-4A27-B60D-8F55BB52A063@intel.com> <555BA850.1090901@gmail.com>
Message-ID: <46CDD500-2A1B-4457-BE17-961AFC50769E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 2:17 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> Any chance you could point me toward the software in question?  Just wondering because it seems like what you are fixing with this is an implementation issue in the application since you really shouldn't be accessing areas outside the scope of the VPD data structure, and doing so is undefined in terms of what happens if you do.

I don't have it, but if you dump VPD via sysfs you will see it comes out as 32k in size. The kernel just blindly provides access to the full 32K space provided by the spec. I'm sure that we agree that the kernel should not go parse it and find the actual size. If it is read via stdio, say fread, the read access would be whatever buffer size it chooses to use.

If you looked at the quirks, you might have noticed that Broadcom limited the VPD access for some devices for functional reasons. That is what gave me the idea for limiting access to what was possibly there. With the existing Intel Ethernet quirk, it seemed like a simple thing to do.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150519/ccc13c77/attachment.asc>
