From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 15 May 2018 22:17:04 +0000
Subject: [Intel-wired-lan] Does a VF know that it is "trusted"?
In-Reply-To: <5c8eebdc-7ab6-877c-fc2b-c690bd19fee4@oracle.com>
References: <51a0f92e-7b0e-e657-fcd8-b636ff8b7937@oracle.com>
 <F6FB0E698C9B3143BDF729DF22286646C4D7B0F0@ORSMSX116.amr.corp.intel.com>
 <9BBC4E0CF881AA4299206E2E1412B6267A88651B@ORSMSX102.amr.corp.intel.com>
 <5c8eebdc-7ab6-877c-fc2b-c690bd19fee4@oracle.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882E25252@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Shannon Nelson
> Sent: Tuesday, May 15, 2018 11:13 AM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] Does a VF know that it is "trusted"?
> 
> On 5/15/2018 10:58 AM, Wyborny, Carolyn wrote:
> > No, the intent is that the VF does not know its trusted or not.  It asks and if it
> *is* trusted, then the PF grants the request.  VF only knows if the request was
> granted or not.  That is the current design anyway.  Mitch can probably comment
> more.
> >
> 
> Thanks - that's what I thought, but wanted to be sure.  The case I have
> in mind is where the VF might advertise additional netdev features if it
> knows it is trusted.  Obviously, I'm thinking about IPsec offloads, but
> I would think this could apply to other features as well.
> 
> The problem I see is that right now, if IPsec offload capability is
> added to the VF, but only allowed when trusted, the VF must blindly
> advertise its support even if the PF is just going to NAK the request.
> That leads to a poor user experience.
> 
> Hmmm...
> 
> sln
> 

The VF could advertise it's supported until it gets a NAK on the related operations? Or some mechanism to check if a feature is enabled could be added?

Thanks,
Jake
 
