From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 19 May 2015 21:04:17 +0000
Subject: [Intel-wired-lan] [PATCH] pci: Limit VPD reads for all Intel
 Ethernet devices
In-Reply-To: <555B9F74.3040004@redhat.com>
References: <20150519000042.56109.69779.stgit@mdrustad-wks.jf.intel.com>
 <555B5CBF.1090902@redhat.com>
 <4AD84211-965C-4F0B-A7F4-3E6CCE6567E3@intel.com>
 <555B77E5.5060006@redhat.com>
 <99014381-25AB-416D-8E09-C431B5CD5A6C@intel.com>
 <555B9F74.3040004@redhat.com>
Message-ID: <DA06AAB6-CE9B-4A27-B60D-8F55BB52A063@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 19, 2015, at 1:39 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> So how does this improve boot time anyway?  The original patch description said this improved boot time and reduced memory usage but I have yet to find where any of those gains would actually occur.  If you can point me in that direction I might have a better idea of the motivations behind this.

I have to admit that you won't find them in the kernel, but systems that read VPD in the course of starting up will benefit by not reading lots of useless stuff so slowly. At least those reads will be slow on any device that reads VPD from slow hardware. Since the kernel would never perform any of those reads itself, in isolation the kernel has no benefit. However the system gets a benefit.

I can delete the reference to a memory benefit, since it would be a fleeting benefit at most and not a kernel memory footprint issue.

This is not a big deal for me. If you don't see the value, drop it. Some people are interested in speeding up boot. Apparently VPD is now being accessed in parallel by user space as a result of such work, exposing the problem addressed in the other patch. I saw this opportunity while trying to resolve that issue. If it isn't worth it, drop it.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150519/aa372f3f/attachment.asc>
