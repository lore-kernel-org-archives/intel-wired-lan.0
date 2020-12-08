From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 8 Dec 2020 10:42:43 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <20201208100040.0d57742a@carbon>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com> <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201208100040.0d57742a@carbon>
Message-ID: <1c327ddf-f361-8abe-9f8d-605f05ddcc7a@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/8/20 10:00 AM, Jesper Dangaard Brouer wrote:
> On Mon, 07 Dec 2020 12:52:22 -0800
> John Fastabend <john.fastabend@gmail.com> wrote:
> 
>>> Use-case(1): Cloud-provider want to give customers (running VMs) ability
>>> to load XDP program for DDoS protection (only), but don't want to allow
>>> customer to use XDP_TX (that can implement LB or cheat their VM
>>> isolation policy).
>>
>> Not following. What interface do they want to allow loading on? If its
>> the VM interface then I don't see how it matters. From outside the
>> VM there should be no way to discover if its done in VM or in tc or
>> some other stack.
>>
>> If its doing some onloading/offloading I would assume they need to
>> ensure the isolation, etc. is still maintained because you can't
>> let one VMs program work on other VMs packets safely.
>>
>> So what did I miss, above doesn't make sense to me.
> 
> The Cloud-provider want to load customer provided BPF-code on the
> physical Host-OS NIC (that support XDP).  The customer can get access
> to a web-interface where they can write or upload their BPF-prog.
> 
> As multiple customers can upload BPF-progs, the Cloud-provider have to
> write a BPF-prog dispatcher that runs these multiple program.  This
> could be done via BPF tail-calls, or via Toke's libxdp[1], or via
> devmap XDP-progs per egress port.
> 
> The Cloud-provider don't fully trust customers BPF-prog.   They already
> pre-filtered traffic to the given VM, so they can allow customers
> freedom to see traffic and do XDP_PASS and XDP_DROP.  They
> administratively (via ethtool) want to disable the XDP_REDIRECT and
> XDP_TX driver feature, as it can be used for violation their VM
> isolation policy between customers.
> 
> Is the use-case more clear now?

I think we're talking about two different things. The use case as I understood
it in (1) mentioned to be able to disable XDP_TX for NICs that are deployed in
the VM. This would be a no-go as-is since that would mean my basic assumption
for attaching XDP progs is gone in that today return codes pass/drop/tx is
pretty much available everywhere on native XDP supported NICs. And if you've
tried it on major cloud providers like AWS or Azure that offer SRIOV-based
networking that works okay and further restricting this would mean breakage of
existing programs.

What you mean here is "offload" from guest to host which is a different use
case than what likely John and I read from your description in (1). Such program
should then be loaded via BPF offload API. Meaning, if offload is used and the
host is then configured to disallow XDP_TX for such requests from guests, then
these get rejected through such facility, but if the /same/ program was loaded as
regular native XDP where it's still running in the guest, then it must succeed.
These are two entirely different things.

It's not clear to me whether some ethtool XDP properties flag is the right place
to describe this (plus this needs to differ between offloaded / non-offloaded progs)
or whether this should be an implementation detail for things like virtio_net e.g.
via virtio_has_feature(). Feels more like the latter to me which already has such
a facility in place.
