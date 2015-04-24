From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 23 Apr 2015 17:09:50 -0700
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Pull timestamp from fragment
 before adding it to skb
In-Reply-To: <55393795.6000000@gmail.com>
References: <CAM_iQpVyQoGZZByC1n3sAP0Txyf7H60WnKdNCBX+K0s8Wezscw@mail.gmail.com>
 <55393795.6000000@gmail.com>
Message-ID: <CAM_iQpUUweF50ucho2+v6zdLtkWfKp1k3NDXDU8znAZcXYwcFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 23, 2015 at 11:19 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On 04/23/2015 10:10 AM, Cong Wang wrote:
>> On Wed, Apr 22, 2015 at 9:49 PM, Alexander Duyck
>> <alexander.h.duyck@redhat.com> wrote:
>>> This change makes it so that we pull the timestamp from the fragment before
>>> we add it to the skb.  By doing this we can avoid a possible issue in which
>>> the fragment can possibly be less than IGB_RX_HDR_LEN due to the timestamp
>>> being pulled after the copybreak check.
>>
>> You said the first frag is always 2K if it exists. If this is not true, then
>> my patch is needed too.
>
> I said the first fragment is always 2K if a secondary frag exists.  We
> always reserve 2K for each buffer so the memory is there and could be
> read, it just wouldn't contain valid header data once you get past the
> size reported by the Rx descriptor.
>
> The issue is the data_len can get mangled due to the 16 bytes for the
> timestamp being unaccounted for.  The goal was to fix this and not
> introduce any other vulnerabilities or performance regressions which was
> my concern with your patch.  I would prefer to err on the side of
> parsing fewer bytes than possibly parsing a full frame if someone
> decided to submit one that was nothing but tunnel headers for instance.

Looking deeper into this, I think we need to do nothing here.

a) We pass skb as NULL in eth_get_headlen(), in which case tunnel
case is not handled;

b) Even with tunnel headers, I can't think out a case we can construct
a valid header longer than 256 to fool eth_get_headlen().

I am fine with leaving as it is.
