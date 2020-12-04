From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 04 Dec 2020 18:20:56 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
Message-ID: <87pn3p7aiv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 12/4/20 1:46 PM, Maciej Fijalkowski wrote:
>> On Fri, Dec 04, 2020 at 01:18:31PM +0100, Toke H?iland-J?rgensen wrote:
>>> alardam at gmail.com writes:
>>>> From: Marek Majtyka <marekx.majtyka@intel.com>
>>>>
>>>> Implement support for checking what kind of xdp functionality a netdev
>>>> supports. Previously, there was no way to do this other than to try
>>>> to create an AF_XDP socket on the interface or load an XDP program and see
>>>> if it worked. This commit changes this by adding a new variable which
>>>> describes all xdp supported functions on pretty detailed level:
>>>
>>> I like the direction this is going! :)
>>>
>>>>   - aborted
>>>>   - drop
>>>>   - pass
>>>>   - tx
>
> I strongly think we should _not_ merge any native XDP driver patchset
> that does not support/implement the above return codes. Could we
> instead group them together and call this something like XDP_BASE
> functionality to not give a wrong impression? If this is properly
> documented that these are basic must-have _requirements_, then users
> and driver developers both know what the expectations are.

I think there may have been drivers that only did DROP/PASS on first
merge; but adding TX to the "base set" is fine by me, as long as it's
actually enforced ;)

(As in, we originally said the same thing about the full feature set and
that never really worked out).

>>>>   - redirect
>>>
>>> Drivers can in principle implement support for the XDP_REDIRECT return
>>> code (and calling xdp_do_redirect()) without implementing ndo_xdp_xmit()
>>> for being the *target* of a redirect. While my quick grepping doesn't
>>> turn up any drivers that do only one of these right now, I think we've
>>> had examples of it in the past, so it would probably be better to split
>>> the redirect feature flag in two.
>>>
>>> This would also make it trivial to replace the check in __xdp_enqueue()
>>> (in devmap.c) from looking at whether the ndo is defined, and just
>>> checking the flag. It would be great if you could do this as part of
>>> this series.
>>>
>>> Maybe we could even make the 'redirect target' flag be set automatically
>>> if a driver implements ndo_xdp_xmit?
>> 
>> +1
>> 
>>>>   - zero copy
>>>>   - hardware offload.
>
> One other thing that is quite annoying to figure out sometimes and not always
> obvious from reading the driver code (and it may even differ depending on how
> the driver was built :/) is how much XDP headroom a driver really provides.
>
> We tried to standardize on a minimum guaranteed amount, but unfortunately not
> everyone seems to implement it, but I think it would be very useful to query
> this from application side, for example, consider that an app inserts a BPF
> prog at XDP doing custom encap shortly before XDP_TX so it would be useful to
> know which of the different encaps it implements are realistically possible on
> the underlying XDP supported dev.

How many distinct values are there in reality? Enough to express this in
a few flags (XDP_HEADROOM_128, XDP_HEADROOM_192, etc?), or does it need
an additional field to get the exact value? If we implement the latter
we also run the risk of people actually implementing all sorts of weird
values, whereas if we constrain it to a few distinct values it's easier
to push back against adding new values (as it'll be obvious from the
addition of new flags).

-Toke

