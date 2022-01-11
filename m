From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 11 Jan 2022 07:30:53 +0000
Subject: [Intel-wired-lan] [PATCH v4 net-next 7/9] ixgbe: pass bi->xdp
 to ixgbe_construct_skb_zc() directly
In-Reply-To: <20211208140702.642741-8-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
 <20211208140702.642741-8-alexandr.lobakin@intel.com>
Message-ID: <MW3PR11MB45549D6C03955849FC75BCF89C519@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Alexander Lobakin
>Sent: Wednesday, December 8, 2021 7:37 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Song Liu <songliubraving@fb.com>; Jesper Dangaard Brouer
><hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Yonghong
>Song <yhs@fb.com>; Martin KaFai Lau <kafai@fb.com>; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; Andrii
>Nakryiko <andrii@kernel.org>; Bj?rn T?pel <bjorn@kernel.org>;
>netdev at vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; KP Singh
><kpsingh@kernel.org>; bpf at vger.kernel.org; David S. Miller
><davem@davemloft.net>; linux-kernel at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH v4 net-next 7/9] ixgbe: pass bi->xdp to
>ixgbe_construct_skb_zc() directly
>
>To not dereference bi->xdp each time in ixgbe_construct_skb_zc(), pass bi-
>>xdp as an argument instead of bi. We can also call
>xsk_buff_free() outside of the function as well as assign bi->xdp to NULL,
>which seems to make it closer to its name.
>
>Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
