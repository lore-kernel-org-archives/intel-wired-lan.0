From: KY Srinivasan <kys@microsoft.com>
Date: Wed, 20 Apr 2016 13:44:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf:
 Support Windows hosts (Hyper-V)
In-Reply-To: <1461133482.2923.28.camel@intel.com>
References: <1461118655-28103-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-2-git-send-email-kys@microsoft.com>
 <1461133482.2923.28.camel@intel.com>
Message-ID: <BL2PR03MB19088BCE884A63A4EA188AB8A06D0@BL2PR03MB1908.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jeff Kirsher [mailto:jeffrey.t.kirsher at intel.com]
> Sent: Tuesday, April 19, 2016 11:25 PM
> To: KY Srinivasan <kys@microsoft.com>; davem at davemloft.net;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> devel at linuxdriverproject.org; olaf at aepfle.de; apw at canonical.com;
> jasowang at redhat.com; eli at mellanox.com; jackm at mellanox.com;
> yevgenyp at mellanox.com; john.ronciak at intel.com; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf: Support
> Windows hosts (Hyper-V)
> 
> On Tue, 2016-04-19 at 19:17 -0700, K. Y. Srinivasan wrote:
> > On Hyper-V, the VF/PF communication is a via software mediated path
> > as opposed to the hardware mailbox. Make the necessary
> > adjustments to support Hyper-V.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> > ????????V2: Addressed most of the comments from
> > ??????????? Alexander Duyck <alexander.duyck@gmail.com>
> > ??????????? and Rustad, Mark D <mark.d.rustad@intel.com>.
> >
> > ????????V3: Addressed additional comments from
> > ??????????? Alexander Duyck <alexander.duyck@gmail.com>
> >
> > ????????V4: Addressed kbuild errors reported by:
> > ??????????? kbuild test robot <lkp@intel.com>
> >
> > ????????V5: Addressed additional comments from
> > ??????????? Alexander Duyck <alexander.duyck@gmail.com>
> 
> First I commend you on actually making a proper changelog for a patch.
> ?The only issue I have is that the changelog provides not actual
> changes. ?Saying you reacted to comments does not summarize what the
> actual changes were. ?I purposely did not review the earlier versions
> because by the time I went to do a review, there was another version
> already submitted. ?So your changelog requires that users look at all
> the previous emails to actually see what Alex and Mark requested in
> changes.
> 
> I am telling you this for future patches, it will not impact these
> patches, just really disappointing. ?I will take the extra time to
> track down all the previous emails and the changes requested to ensure
> you made all the changes that were requested of you. :-( ?This will
> just delay when I apply the patches for testing.

Thank you for taking the time. Here is a brief summary of all the changes (from
the initial version - ignoring cosmetic changes):

1. Changed the check for running on Hyper-V to be instruction set 
architecture independent. This is now based on device IDs (since we have
unique device IDs when running on Hyper-V).

2. Introduced a bunch of stub functions to eliminate a bunch of checks I initially
had in ixgbev_main.c. I now fully populate the mac operations many of the entry
points being stubs (ixgbevf_hv_mac_ops).

3. Added a check to ensure that we return appropriate error if  PCI_MMCONFIG
Is not defined - on Hyper-V we get the mac address by reading the PCI config space
at special offset.

4. Made the following functions standalone functions:
 ixgbevf_hv_rlpml_set_vf() and
ixgbevf_negotiate_api_version()
These are the Hyper-V variants. We now have the check at the call sites
in ixgbevf_main.c.

Hope this helps and again I am sorry for not including the summary.

Regards,

K. Y
> 
> >
> > ?drivers/net/ethernet/intel/ixgbevf/ixgbevf.h????? |?? 12 ++
> > ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |?? 31 +++-
> > ?drivers/net/ethernet/intel/ixgbevf/mbx.c????????? |?? 12 ++
> > ?drivers/net/ethernet/intel/ixgbevf/vf.c?????????? |? 216
> > +++++++++++++++++++++
> > ?drivers/net/ethernet/intel/ixgbevf/vf.h?????????? |??? 2 +
> > ?5 files changed, 266 insertions(+), 7 deletions(-)
