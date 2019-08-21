From: Eelco Chaudron <echaudro@redhat.com>
Date: Wed, 21 Aug 2019 12:09:06 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <20190820151611.10727-1-i.maximets@samsung.com>
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com>
Message-ID: <9EFD9B47-2CD0-4D7A-BA22-D87018894E91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 20 Aug 2019, at 17:16, Ilya Maximets wrote:

> Tx code doesn't clear the descriptor status after cleaning.
> So, if the budget is larger than number of used elems in a ring, some
> descriptors will be accounted twice and xsk_umem_complete_tx will move
> prod_tail far beyond the prod_head breaking the comletion queue ring.
>
> Fix that by limiting the number of descriptors to clean by the number
> of used descriptors in the tx ring.
>
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>
> Not tested yet because of lack of available hardware.
> So, testing is very welcome.
>
Hi Ilya, this patch fixes the issue I reported earlier on the Open 
vSwitch mailing list regarding complete queue overrun.

Tested-by: Eelco Chaudron <echaudro@redhat.com>

<SNIP>
