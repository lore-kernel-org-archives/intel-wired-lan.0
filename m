From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 23 Jun 2020 11:18:00 +0200
Subject: [Intel-wired-lan] Fw: [Bug 208275] New: kernel hang
 occasionally while running the sample of xdpsock
In-Reply-To: <CAPydje_AdWjOoS4AJ5BMyFYLEsNciyNv_8YwkEMbO2B+Co0DfA@mail.gmail.com>
References: <20200622090824.41cff8a3@hermes.lan>
 <CAJ+HfNhhpZoeoZC5gS93Lbc5GvDUO9m0RrKNFU=kU0v+AXe=ig@mail.gmail.com>
 <CAJ+HfNgG4dBTf7Ei2CmuedQLnv-nOqpf4Nuep+FB9Oxob+zhdA@mail.gmail.com>
 <CAPydje_AdWjOoS4AJ5BMyFYLEsNciyNv_8YwkEMbO2B+Co0DfA@mail.gmail.com>
Message-ID: <CAJ+HfNjOUsJAOMmz6wq3zoxRQ5HtBjFzkJ64eCWiPWxkFWDGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 23 Jun 2020 at 05:45, Yahui Chen <goodluckwillcomesoon@gmail.com> wrote:
>
> Hi, Bjorn, Thank your response.
> Could you describe it more clearly? I can not get it exactly.
> Thx.
>

When XDP is enabled, the ixgbe NIC does a (somewhat heavy)
reconfiguration. During the reconfiguration, for some reason, the
rx_buffer->page is NULL in the following call chain:
  ixgbe_down()->ixgbe_clean_all_rx_rings()->ixgbe_clean_rx_ring()->__page_frag_cache_drain()

This results in that when __page_frag_cache_drain() want to touch the
reference counter, you get a NULL pointer dereference.

[277994.329145] BUG: kernel NULL pointer dereference, address: 0000000000000034
...
[277994.329428] RIP: 0010:__page_frag_cache_drain+0x5/0x40
[277994.329463] Code: d2 ff ff 31 f6 84 c0 74 04 0f b6 73 51 48 89 df
e8 70 ff ff ff eb dc 48 83 eb 01 eb d0 0f 1f 84 00 00 00 00 00 0f 1f
44 00 00 <f0> 29 77 34 74 01 c3 48 8b 07 55 48 89 e5 a9 00 00 01 00 74
0f 0f

2a:*    f0 29 77 34              lock sub %esi,0x34(%rdi)        <--
trapping instruction

I tried to reproduce the issue, but without success so far. I'll keep
looking for the bug. Hopefully someone from Intel with better insight
into ixgbe can help!


Bj?rn
