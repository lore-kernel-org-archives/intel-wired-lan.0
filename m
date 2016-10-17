From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 17 Oct 2016 15:37:51 -0700
Subject: [Intel-wired-lan] [PATCH V3 RFC 2/2] ixgbe: ixgbe_atr() compute
 l4_proto only if non-paged data has network/transport headers
In-Reply-To: <CAKgT0Ue7HL4CWdF2jBzLYOqXuO2=J9GeF79qfcdOWB7+cA0_3Q@mail.gmail.com>
References: <cover.1476737917.git.sowmini.varadhan@oracle.com>
 <07bf787b2a346e12ca6e57edaf1a3025de9ae5dc.1476737917.git.sowmini.varadhan@oracle.com>
 <CAKgT0Ue7HL4CWdF2jBzLYOqXuO2=J9GeF79qfcdOWB7+cA0_3Q@mail.gmail.com>
Message-ID: <1476743871.2326.52.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-10-17 at 15:29 -0700, Alexander Duyck wrote:
> On Mon, Oct 17, 2016 at 2:12 PM, Sowmini Varadhan
> <sowmini.varadhan@oracle.com> wrote:
> > 
> > For some Tx paths (e.g., tpacket_snd()), ixgbe_atr may be
> > passed down an sk_buff that has the network and transport
> > header in the paged data, so it needs to make sure these
> > headers are available in the headlen bytes to calculate the
> > l4_proto.
> > 
> > This patch expect that network and transport headers are
> > already available in the non-paged header dat.??The assumption
> > is that the caller has set this up if l4_proto based Tx
> > steering is desired.
> > 
> > Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> 
> This all looks correct to me.??I would recommend having Jeff pull it
> in to be submitted to the net queue.
> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>

Sowmini, can you re-submit this to intel-wired-lan but without the RFC in
the title?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161017/55d2f638/attachment.asc>
