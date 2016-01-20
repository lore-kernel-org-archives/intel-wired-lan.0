From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 20 Jan 2016 14:39:50 -0800
Subject: [Intel-wired-lan] [next, S23,
	06/13] i40e/i40evf: tunnels can be generic
In-Reply-To: <569F04DF.7070102@gmail.com>
References: <1449705033-4968-7-git-send-email-joshua.a.hay@intel.com>
 <569F04DF.7070102@gmail.com>
Message-ID: <20160120143950.00002ba0@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 19 Jan 2016 19:54:07 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On 12/09/2015 03:50 PM, Hay, Joshua A wrote:
> > From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > -	if (!(tx_flags & I40E_TX_FLAGS_VXLAN_TUNNEL)) {
> > +	if ((tx_flags & I40E_TX_FLAGS_TUNNEL)) {
> >   		/* snag network header to get L4 type and address */
> >   		hdr.network = skb_network_header(skb);
> >
> 
> So this patch has a major bug right here.  Specifically it is disabling 
> ATR for everything since the logic got flipped an you are checking the 
> outer headers for tunneled frames, and the inner headers for 
> non-tunneled frames.

I've got a patch ready that fixes the "major bug" part, which appears
to be due to be a combination of several factors leading to this point
where the code was broken.  Thank you VERY much for catching this.

> There is another bug a bit further down from here where the variable 
> protocol is used which means it is outer header only and as such breaks 
> any cases where you have v4 over v6 or v6 over v4.

Since this issue was not introduced in this patch, I'm going to punt to
a separate patch to fix the "protocol".

