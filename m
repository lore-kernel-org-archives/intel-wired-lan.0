From: Stanislav Fomichev <sdf@fomichev.me>
Date: Fri, 19 Apr 2019 16:47:44 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v5 5/6] net: pass net
 argument to the eth_get_headlen
In-Reply-To: <20190419233749.x6ein5ksltfcuarp@ast-mbp.dhcp.thefacebook.com>
References: <20190415173801.257254-1-sdf@google.com>
 <20190415173801.257254-6-sdf@google.com>
 <20190419002851.7efgfnyo3swvtwvo@ast-mbp.dhcp.thefacebook.com>
 <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
 <20190419045026.ayalgmunvizwxc7j@ast-mbp.dhcp.thefacebook.com>
 <20190419232944.GA27730@mini-arch.hsd1.ca.comcast.net>
 <20190419233749.x6ein5ksltfcuarp@ast-mbp.dhcp.thefacebook.com>
Message-ID: <20190419234744.GB27730@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/19, Alexei Starovoitov wrote:
> On Fri, Apr 19, 2019 at 04:29:44PM -0700, Stanislav Fomichev wrote:
> > On 04/18, Alexei Starovoitov wrote:
> > > On Thu, Apr 18, 2019 at 05:43:50PM -0700, Stanislav Fomichev wrote:
> > > > On 04/18, Alexei Starovoitov wrote:
> > > > > On Mon, Apr 15, 2019 at 10:38:00AM -0700, Stanislav Fomichev wrote:
> > > > > > Update all users eth_get_headlen to pass network namespace
> > > > > > and pass it down to the flow dissector. This commit is a noop
> > > > > > until administrator inserts BPF flow dissector program.
> > > > > > 
> > > > > > Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > > > > > Cc: Saeed Mahameed <saeedm@mellanox.com>
> > > > > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > > > > > Cc: intel-wired-lan at lists.osuosl.org
> > > > > > Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> > > > > > Cc: Salil Mehta <salil.mehta@huawei.com>
> > > > > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > > > > Cc: Igor Russkikh <igor.russkikh@aquantia.com>
> > > > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ... 
> > > > > Also please add C based test for skb-less flow_dissector.
> > > > > Current test_flow_dissector.sh doesn't seem to cover it.
> > > > It doesn't look like we can exercise skb-less flow dissector from
> > > > test_flow_dissector.sh; we need to trigger some driver code, which is
> > > > hard when we send the packets on the localhost in
> > > > test_flow_dissector.sh.
> > > > 
> > > > To test skb-less dissector I convert BPF_PROG_TEST_RUN to always use skb-less
> > > > mode. test_flow_dissector.sh tests skb-mode, prog_tests/flow_dissector.c
> > > > tests skb-less mode.
> > > 
> > > I saw that but I'm afraid it's not enough.
> > > tun_get_user() is calling it, so it should be possible to test
> > > skb-less mode via tun.
> > Spent some time today looking into how to exercise this path in the tun
> > driver: doing writev() with IFF_NAPI_FRAGS IFF_TAP device would trigger
> > eth_get_headlen, but it looks like there is no way to do a test with
> > pass/no-pass result around that.
> > 
> > The problem is - we don't actually do anything with the result of
> > eth_get_headlen, there is only a sanity check for "headlen >
> > skb_headlen(skb)" which can't trigger for BPF flow dissector; we
> > carefully clamp thoff/nhoff and should not return offset outside the
> > input buffer.
> > 
> > By reading git history it looks like this call to eth_get_headlen was
> > added there to only make it possible for tools like syzbot to fuzz flow
> > dissector. That's why we don't care about the result, we just do that
> > simple sanity check. The main goal is to trigger some problem
> > (loop/warning) in the flow dissector code.
> > 
> > tl;dr - no mater which bpf flow dissector is attached to the namespace,
> > it would not change behavior of the tun device; even empty 'return
> > false' program would not alter it.
> 
> sure, but the program will run and the test can validate that the program
> saw valid packet, parsed it correctly and returned correct dissection.
> The results can be stored in a map and validated by the test.
SG, that's doable; that would make bpf_flow.c less generic because it would
have to have this map which would export the last dissection, but that
should be fine, I guess.

(I planned to use bpf_flow.c internally instead of writing another one).

> iirc you were saying that you'll have one program doing dissection
> for with-skb and skb-less cases.
Correct.

> I think it's important to have such program in selftests and being
> run continuously for both cases.
Ok, in this case, I can write a small userspace program that writes some
dummy packet into a tap device (triggers eth_get_headlen) and reads back
and verifies bpf_flow_keys from the shared map.

Correct me if I misunderstood something. Otherwise, I'll get back to you
with a v6+test.
