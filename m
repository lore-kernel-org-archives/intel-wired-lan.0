From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Thu,  9 Dec 2021 18:38:16 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 2/9] i40e: respect
 metadata on XSK Rx to skb
In-Reply-To: <2811b35a-9179-88ce-d87a-e1f824851494@redhat.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-3-alexandr.lobakin@intel.com>
 <2811b35a-9179-88ce-d87a-e1f824851494@redhat.com>
Message-ID: <20211209173816.5157-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Thu, 9 Dec 2021 09:27:37 +0100

> On 08/12/2021 15.06, Alexander Lobakin wrote:
> > For now, if the XDP prog returns XDP_PASS on XSK, the metadata will
> > be lost as it doesn't get copied to the skb.
> 
> I have an urge to add a newline here, when reading this, as IMHO it is a 
> paragraph with the problem statement.
> 
> > Copy it along with the frame headers. Account its size on skb
> > allocation, and when copying just treat it as a part of the frame
> > and do a pull after to "move" it to the "reserved" zone.
> 
> Also newline here, as next paragraph are some extra details, you felt a 
> need to explain to the reader.
> 
> > net_prefetch() xdp->data_meta and align the copy size to speed-up
> > memcpy() a little and better match i40e_costruct_skb().
>                                       ^^^^^^xx^^^^^^^^^
> 
> You have a general misspelling of this function name in all of your 
> commit messages.

Oh gosh, I thought I don't have attention deficit. Thanks, maybe
Tony will fix it for me or I could send a follow-up (or resend if
needed, I saw those were already applied to dev-queue).

> 
> --Jesper

Al
