From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 20 Jul 2016 14:20:30 -0700
Subject: [Intel-wired-lan] Packet Drop in Intel Fortville Cards
In-Reply-To: <1469049421.2684.61.camel@intel.com>
References: <CGME20160714105203epcms3p366907a0c3efae8193ef7baba79ed9094@epcms3p3>
 <20160714105203epcms3p366907a0c3efae8193ef7baba79ed9094@epcms3p3>
 <1469049421.2684.61.camel@intel.com>
Message-ID: <1469049630.2684.65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-07-20 at 14:17 -0700, Jeff Kirsher wrote:
> On Thu, 2016-07-14 at 10:52 +0000, ??? wrote:
> > 
> > Dear Anjali Singhai Jain,
> > ?
> > I am Hyochang Nam in SECUI, Korea.
> > In these days, we found an odd symptom in Intel Fortville cards.
> > When we execute tcpdump command in linux shell,
> > packet drop happened even though the traffic was not heavy.
> > We think this symptom was caused by interface reset codes in your
> > previous patch:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/d
> > ri
> > vers/net/ethernet/intel/i40e/i40e_main.c?id=92faef85613d6d56803ad6130f6
> > da
> > f4a803deddc?
> > Whenever we execute tcpdump, network interfaces are reset,
> > and during the reset timing packets are always dropped in NIC side.
> > Moreover, we had not met this issue?in old device drivers of i40e.
> > ?
> > We had reported this issue to Intel IPS ( Case #0008532, Click Here ),
> > and SK San in Intel had tried to reproduce it, but failed.
> > ?
> > Anyway, in our side, we are struggling this issue still.
> > Our test environments are as follows:
> > ? - OS: CentOS 7.2
> > ??- Device Driver: i40e-1.5.18
> > ? - Card: X710 DA4
> > ?
> > Would you let us know this symptom is related to your patch?
> > or would you?give us any comment for this symptom?
> Please CC e1000-devel and intel-wired-lan mailing lists, so that all the
> appropriate developers have a chance to review/respond. ?Especially if
> the
> person you are emailing is out or on vacation, you can get a quicker
> response by CC'ing the mailing lists as well.
> 
> I have gone ahead and CC'd the appropriate mailing lists for you.

CC'd the correct intel-wired-lan mailing list this time... :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160720/e6c5f381/attachment.asc>
