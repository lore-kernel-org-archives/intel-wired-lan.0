From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 17 Oct 2016 15:48:40 -0700
Subject: [Intel-wired-lan] [PATCH V3 RFC 2/2] ixgbe: ixgbe_atr() compute
 l4_proto only if non-paged data has network/transport headers
In-Reply-To: <20161017224702.GA17588@oracle.com>
References: <cover.1476737917.git.sowmini.varadhan@oracle.com>
 <07bf787b2a346e12ca6e57edaf1a3025de9ae5dc.1476737917.git.sowmini.varadhan@oracle.com>
 <CAKgT0Ue7HL4CWdF2jBzLYOqXuO2=J9GeF79qfcdOWB7+cA0_3Q@mail.gmail.com>
 <1476743871.2326.52.camel@intel.com> <20161017224702.GA17588@oracle.com>
Message-ID: <1476744520.2326.54.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-10-17 at 18:47 -0400, Sowmini Varadhan wrote:
> On (10/17/16 15:37), Jeff Kirsher wrote:
> > > Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> >?
> > Sowmini, can you re-submit this to intel-wired-lan but without the RFC
> in
> > the title?
> 
> V4 resubmitted.. I think I just inadvertently forgot to add Alex as the
> reviewed-by.. could you please fix that (or I can resubmit v5 if needed).

No need to resubmit, I can make sure Alex's reviewed-by gets added.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161017/cedd4193/attachment-0001.asc>
