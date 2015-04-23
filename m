From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 23 Apr 2015 10:10:45 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Pull timestamp from fragment
	before adding it to skb
Message-ID: <CAM_iQpVyQoGZZByC1n3sAP0Txyf7H60WnKdNCBX+K0s8Wezscw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 22, 2015 at 9:49 PM, Alexander Duyck
<alexander.h.duyck@redhat.com> wrote:
> This change makes it so that we pull the timestamp from the fragment before
> we add it to the skb.  By doing this we can avoid a possible issue in which
> the fragment can possibly be less than IGB_RX_HDR_LEN due to the timestamp
> being pulled after the copybreak check.


You said the first frag is always 2K if it exists. If this is not true, then
my patch is needed too.

>
> While making this change I realized we could also pull the rest of the
> igb_pull_tail function into igb_add_rx_frag since in the case of igb,
> unlike ixgbe, we are able to unmap the entire buffer before calling
> add_rx_frag so merging the two allows for sharing of code between the two
> merged functions.

Can you make a simple change for stable? Of course unless this
patch is targeted for net-next, but $subject doesn't say so.

Also, please Cc netdev, I am not on intel-wired-lan list.

BTW, it would be nice to Cc me for all 3 patches, as they might
be related for review.
