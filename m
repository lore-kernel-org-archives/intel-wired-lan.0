From: Jiri Pirko <jiri@resnulli.us>
Date: Sat, 7 Jan 2017 09:27:47 +0100
Subject: [Intel-wired-lan] [net-next PATCH v2 5/6] i40e: Add TX and RX
 support in switchdev mode.
In-Reply-To: <20170106110858.1598bbb8@laptop>
References: <1483466874-2962-1-git-send-email-sridhar.samudrala@intel.com>
 <1483466874-2962-6-git-send-email-sridhar.samudrala@intel.com>
 <20170105125656.GB2211@nanopsycho> <586EE461.2000801@intel.com>
 <20170106173035.GA1851@nanopsycho> <20170106110858.1598bbb8@laptop>
Message-ID: <20170107082747.GA2040@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fri, Jan 06, 2017 at 08:08:58PM CET, kubakici at wp.pl wrote:
>On Fri, 6 Jan 2017 18:30:35 +0100, Jiri Pirko wrote:
>> >> > +	skb_dst_drop(skb);
>> >> > +	dst_hold(&priv->vfpr_dst->dst);
>> >> > +	skb_dst_set(skb, &priv->vfpr_dst->dst);
>> >> > +	skb->dev = vsi->netdev;  
>> >> This dst dance seems a bit odd to me. Why don't you just call
>> >> i40e_xmit_frame_ring with an extra arg holding the needed metadata?  
>> >
>> >We don't have TX/RX queues associated with VFPR netdevs, so we need to set
>> >the dev to PF netdev and requeue the skb.  
>> 
>> Still, you eventually call a function within same .c file. Using dst
>> does not look right to me.
>
>Do you mean you don't like reusing the dst_metadata to store the
>representative id?  The missing patch provided the reasoning behind
>this design [1].  It's mostly about being able to comfortably use the
>queuing infrastructure.  Trying to push data from multiple netdevs into
>single ring at driver layer is even less pretty.
>
>[1] http://patchwork.ozlabs.org/patch/710563/

Okay, makes sense. Thanks.

