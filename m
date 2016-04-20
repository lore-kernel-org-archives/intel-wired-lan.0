From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 19 Apr 2016 23:24:42 -0700
Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf:
 Support Windows hosts (Hyper-V)
In-Reply-To: <1461118677-28142-2-git-send-email-kys@microsoft.com>
References: <1461118655-28103-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-2-git-send-email-kys@microsoft.com>
Message-ID: <1461133482.2923.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-04-19 at 19:17 -0700, K. Y. Srinivasan wrote:
> On Hyper-V, the VF/PF communication is a via software mediated path
> as opposed to the hardware mailbox. Make the necessary
> adjustments to support Hyper-V.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
> ????????V2: Addressed most of the comments from
> ??????????? Alexander Duyck <alexander.duyck@gmail.com>
> ??????????? and Rustad, Mark D <mark.d.rustad@intel.com>.
> 
> ????????V3: Addressed additional comments from
> ??????????? Alexander Duyck <alexander.duyck@gmail.com>
> 
> ????????V4: Addressed kbuild errors reported by:
> ??????????? kbuild test robot <lkp@intel.com>
> 
> ????????V5: Addressed additional comments from
> ??????????? Alexander Duyck <alexander.duyck@gmail.com>

First I commend you on actually making a proper changelog for a patch.
?The only issue I have is that the changelog provides not actual
changes. ?Saying you reacted to comments does not summarize what the
actual changes were. ?I purposely did not review the earlier versions
because by the time I went to do a review, there was another version
already submitted. ?So your changelog requires that users look at all
the previous emails to actually see what Alex and Mark requested in
changes.

I am telling you this for future patches, it will not impact these
patches, just really disappointing. ?I will take the extra time to
track down all the previous emails and the changes requested to ensure
you made all the changes that were requested of you. :-( ?This will
just delay when I apply the patches for testing.

> 
> ?drivers/net/ethernet/intel/ixgbevf/ixgbevf.h????? |?? 12 ++
> ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |?? 31 +++-
> ?drivers/net/ethernet/intel/ixgbevf/mbx.c????????? |?? 12 ++
> ?drivers/net/ethernet/intel/ixgbevf/vf.c?????????? |? 216
> +++++++++++++++++++++
> ?drivers/net/ethernet/intel/ixgbevf/vf.h?????????? |??? 2 +
> ?5 files changed, 266 insertions(+), 7 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160419/f4665147/attachment.asc>
