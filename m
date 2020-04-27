From: John Fastabend <john.fastabend@gmail.com>
Date: Sun, 26 Apr 2020 22:37:35 -0700
Subject: [Intel-wired-lan] [PATCH net-next 00/33] XDP extend with
 knowledge of frame size
In-Reply-To: <158757160439.1370371.13213378122947426220.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
Message-ID: <5ea66f9f84ba1_59462aeb755845b813@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jesper Dangaard Brouer wrote:
> (Send for net-next due to all the driver updates)
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
> 
> Use-cases for tail grow/extend:
> (1) IPsec / XFRM needs a tail extend[1][2].
> (2) DNS-cache responses in XDP.
> (3) HAProxy ALOHA would need it to convert to XDP.
> 
> [1] http://vger.kernel.org/netconf2019_files/xfrm_xdp.pdf
> [2] http://vger.kernel.org/netconf2019.html
> 

Hi Jesper, Overall series looks good to me. One question about the
memset on grow though. (typo in specific reply meant data for with and
without the memset would be nice) For a hairpin use case where the
data is then sent back onto the wire it would be nice to avoid that
memset. Could we mark the packet with a flag and then only clear if
the user tries to pass it to the stack for instance?

Lots of patches but also seems OK given the majority are for each
driver.

The comment about the warning being a warn on once also seems like a
good catch.

Thanks,
John
