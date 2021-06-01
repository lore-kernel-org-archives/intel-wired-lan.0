From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 1 Jun 2021 08:57:37 +0200
Subject: [Intel-wired-lan] Regression 5.12.0-rc4 net: ice: significant
 throughput drop
In-Reply-To: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
References: <CAHn8xckNXci+X_Eb2WMv4uVYjO2331UWB2JLtXr_58z0Av8+8A@mail.gmail.com>
Message-ID: <cc58c09e-bbb5-354a-2030-bf8ebb2adc86@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[ ping Robin / Joerg, +Cc Christoph ]

On 5/28/21 10:34 AM, Jussi Maki wrote:
> Hi all,
> 
> While measuring the impact of a kernel patch on our lab machines I stumbled upon
> a performance regression affecting the 100Gbit ICE nic and bisected it
> from range v5.11.1..v5.13-rc3 to the commit:
> a250c23f15c2 iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
> 
> Both recent bpf-next (d6a6a55518) and linux-stable (c4681547bc) are
> affected by the issue.
> 
> The regression shows as a significant drop in throughput as measured
> with "super_netperf" [0],
> with measured bandwidth of ~95Gbps before and ~35Gbps after:
> 
> commit 3189713a1b84 (a250c23^):
> $ ./super_netperf 32 -H 172.18.0.2 -l 10
> 97379.8
> 
> commit a250c23f15c2:
> $ ./super_netperf 32 -H 172.18.0.2 -l 10
> 34097.5
> 
> The pair of test machines have this hardware:
> CPU: AMD Ryzen 9 3950X 16-Core Processor
> MB: X570 AORUS MASTER
> 0a:00.0 Ethernet controller [0200]: Intel Corporation Ethernet
> Controller E810-C for QSFP [8086:1592] (rev 02)
> Kernel config: https://gist.github.com/joamaki/9ee11294c78a8dd2776041f67e5620e7
> 
> [0] https://github.com/borkmann/stuff/blob/master/super_netperf
> 

