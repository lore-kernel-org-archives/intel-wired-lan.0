From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Apr 2019 21:50:28 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v5 5/6] net: pass net
 argument to the eth_get_headlen
In-Reply-To: <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
References: <20190415173801.257254-1-sdf@google.com>
 <20190415173801.257254-6-sdf@google.com>
 <20190419002851.7efgfnyo3swvtwvo@ast-mbp.dhcp.thefacebook.com>
 <20190419004350.GC8631@mini-arch.hsd1.ca.comcast.net>
Message-ID: <20190419045026.ayalgmunvizwxc7j@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 18, 2019 at 05:43:50PM -0700, Stanislav Fomichev wrote:
> On 04/18, Alexei Starovoitov wrote:
> > On Mon, Apr 15, 2019 at 10:38:00AM -0700, Stanislav Fomichev wrote:
> > > Update all users eth_get_headlen to pass network namespace
> > > and pass it down to the flow dissector. This commit is a noop
> > > until administrator inserts BPF flow dissector program.
> > > 
> > > Cc: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> > > Cc: Saeed Mahameed <saeedm@mellanox.com>
> > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > > Cc: intel-wired-lan at lists.osuosl.org
> > > Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> > > Cc: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: Michael Chan <michael.chan@broadcom.com>
> > > Cc: Igor Russkikh <igor.russkikh@aquantia.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
... 
> > Also please add C based test for skb-less flow_dissector.
> > Current test_flow_dissector.sh doesn't seem to cover it.
> It doesn't look like we can exercise skb-less flow dissector from
> test_flow_dissector.sh; we need to trigger some driver code, which is
> hard when we send the packets on the localhost in
> test_flow_dissector.sh.
> 
> To test skb-less dissector I convert BPF_PROG_TEST_RUN to always use skb-less
> mode. test_flow_dissector.sh tests skb-mode, prog_tests/flow_dissector.c
> tests skb-less mode.

I saw that but I'm afraid it's not enough.
tun_get_user() is calling it, so it should be possible to test
skb-less mode via tun.

