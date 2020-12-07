From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 07 Dec 2020 13:03:28 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <eb305a4f-c189-6b32-f718-6e709ef0fa55@iogearbox.net>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <87pn3p7aiv.fsf@toke.dk>
 <eb305a4f-c189-6b32-f718-6e709ef0fa55@iogearbox.net>
Message-ID: <87wnxt6cxb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 12/4/20 6:20 PM, Toke H?iland-J?rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
> [...]
>>> We tried to standardize on a minimum guaranteed amount, but unfortunately not
>>> everyone seems to implement it, but I think it would be very useful to query
>>> this from application side, for example, consider that an app inserts a BPF
>>> prog at XDP doing custom encap shortly before XDP_TX so it would be useful to
>>> know which of the different encaps it implements are realistically possible on
>>> the underlying XDP supported dev.
>> 
>> How many distinct values are there in reality? Enough to express this in
>> a few flags (XDP_HEADROOM_128, XDP_HEADROOM_192, etc?), or does it need
>> an additional field to get the exact value? If we implement the latter
>> we also run the risk of people actually implementing all sorts of weird
>> values, whereas if we constrain it to a few distinct values it's easier
>> to push back against adding new values (as it'll be obvious from the
>> addition of new flags).
>
> It's not everywhere straight forward to determine unfortunately, see also [0,1]
> as some data points where Jesper looked into in the past, so in some cases it
> might differ depending on the build/runtime config..
>
>    [0] https://lore.kernel.org/bpf/158945314698.97035.5286827951225578467.stgit at firesoul/
>    [1] https://lore.kernel.org/bpf/158945346494.97035.12809400414566061815.stgit at firesoul/

Right, well in that case maybe we should just expose the actual headroom
as a separate netlink attribute? Although I suppose that would require
another round of driver changes since Jesper's patch you linked above
only puts this into xdp_buff at XDP program runtime.

Jesper, WDYT?

-Toke

