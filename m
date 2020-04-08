From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2020 09:55:19 -0700
Subject: [Intel-wired-lan] [PATCH RFC v2 00/33] XDP extend with
 knowledge of frame size
In-Reply-To: <158634658714.707275.7903484085370879864.stgit@firesoul>
References: <158634658714.707275.7903484085370879864.stgit@firesoul>
Message-ID: <20200408165519.da6dr5mclqol6g26@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Apr 08, 2020 at 01:50:34PM +0200, Jesper Dangaard Brouer wrote:
> RFC-note: This is only an RFC because net-next is closed.
> - Please ACK patches you like, then I will collect those for later.
> 
> XDP have evolved to support several frame sizes, but xdp_buff was not
> updated with this information. This have caused the side-effect that
> XDP frame data hard end is unknown. This have limited the BPF-helper
> bpf_xdp_adjust_tail to only shrink the packet. This patchset address
> this and add packet tail extend/grow.
> 
> The purpose of the patchset is ALSO to reserve a memory area that can be
> used for storing extra information, specifically for extending XDP with
> multi-buffer support. One proposal is to use same layout as
> skb_shared_info, which is why this area is currently 320 bytes.
> 
> When converting xdp_frame to SKB (veth and cpumap), the full tailroom
> area can now be used and SKB truesize is now correct. For most
> drivers this result in a much larger tailroom in SKB "head" data
> area. The network stack can now take advantage of this when doing SKB
> coalescing. Thus, a good driver test is to use xdp_redirect_cpu from
> samples/bpf/ and do some TCP stream testing.

I did a quick look through the patches. Overall looks good to me.
Nice to see selftests as well.
If you can add an xdp selftest that uses generic xdp on lo or veth
that would be awesome.
I rarely run test_xdp*.sh tests, but run test_progs on every commit.
So having more comprehensive xdp test as part of test_progs will help us
catch breakage sooner.
