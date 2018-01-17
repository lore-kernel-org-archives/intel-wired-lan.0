From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 17 Jan 2018 10:30:43 -0800
Subject: [Intel-wired-lan] Patch for iproute2
In-Reply-To: <34C81C09865FAD44ABA68FB83DDA0E4D9CC5B73B@irsmsx105.ger.corp.intel.com>
References: <34C81C09865FAD44ABA68FB83DDA0E4D9CC5B73B@irsmsx105.ger.corp.intel.com>
Message-ID: <40f5c292-2d7f-c9e5-7be8-a99634b59f83@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/17/2018 4:45 AM, Piatkowski, Robert wrote:
> Hello,
> 
> I want to submit a patch for iproute2 ? taken from 
> https://github.com/eworm-de/iproute2 - we use this version as it 
> contains pretty recent XFRM offload configuration capability.
> 
> During development, we found a stack buffer overflow bug that causes 
> mass deletion of states command to fail under some circumstances. So we 
> developed a fix for that (see attachment).
> 
> The fix was reviewed by Don Skidmore, and he suggested to forward it to 
> you. I tried to make the description sound similar to other commits? 
> description in the repository.
> 
> Is the fix OK in the current state? What are the next steps for me?
> 
> Robert

As it is much easier to respond to a patch when it is in the actual 
email, I've pasted it in below.

 > From 759b7832d917c822b98f8db73b03891150d316a4 Mon Sep 17 00:00:00 2001
 > From: Robert Piatkowski <robert.piatkowski@intel.com>
 > Date: Thu, 11 Jan 2018 11:12:55 -0500
 > Subject: [PATCH] fix stack buffer overflow when removing many states

The subject should name the source tree (iproute2) and the module (xfrm) 
being updated, something like this:
[PATCH iproute2] xfrm: fix stack buffer overflow when removing many states

I imagine Jeff can take this through his/Intel's dev-queue tree, but it 
should end up in the netdev mailing list and copied to Stephen Hemminger 
<stephen@networkplumber.org> and David Ahern <dsahern@gmail.com> 
(iproute2 maintainers) and to
Steffen Klassert <steffen.klassert@secunet.com> (xfrm maintainer).

 >
 > Fix the case then many SAs were deleted using the

s/then/where/
s/were/are/

 > xfrm delall command causing it to fail with various messages,
 > mainly "State buffer overflow".
 >
 > The code did try to delete all the SAs it got from XFRM at once,
 > not keeping in mind the buffer size for the delete command.
 > Now it simply fills up the buffer as much as it can,
 > repeating the deletion a few times - the loop responsible for this
 > is already there in xfrm_state_list_or_deleteall.
 >
 > This has been previously fixed for policies in
 > commit d5eb0564da494e618ad4654abd93461e5e8bbae0.
 >
 > Signed-off-by: Robert Piatkowski <rober.piatkowski@intel.com>
 > Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>

The patch itself looks fine to me.
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>


 > ---
 >  ip/xfrm_state.c | 3 +++
 >  1 file changed, 3 insertions(+)
 >
 > diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
 > index 85d959cc..08052ffd 100644
 > --- a/ip/xfrm_state.c
 > +++ b/ip/xfrm_state.c
 > @@ -1103,6 +1103,9 @@ static int xfrm_state_keep(const struct 
sockaddr_nl *who,
 >  		return -1;
 >  	}
 >
 > +	if (xb->offset + NLMSG_LENGTH(sizeof(*xsid)) > xb->size)
 > +		return 0;
 > +
 >  	new_n = (struct nlmsghdr *)(xb->buf + xb->offset);
 > 	new_n->nlmsg_len = NLMSG_LENGTH(sizeof(*xsid));
 > 	new_n->nlmsg_flags = NLM_F_REQUEST;
 > --
 > 2.13.6


