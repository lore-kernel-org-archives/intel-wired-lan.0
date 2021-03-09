From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 9 Mar 2021 08:29:55 +0100
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix NULL pointer
 dereference in ethtool loopback test
In-Reply-To: <161523611656.36376.3641992659589167121.stgit@localhost.localdomain>
References: <161523611656.36376.3641992659589167121.stgit@localhost.localdomain>
Message-ID: <CAJ+HfNiDZ+iw50W-N9KprHDygzMZcrTteX1KVpmXC0dafDi-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 8 Mar 2021 at 21:42, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexanderduyck@fb.com>
>
> The ixgbe driver currently generates a NULL pointer dereference when
> performing the ethtool loopback test. This is due to the fact that there
> isn't a q_vector associated with the test ring when it is setup as
> interrupts are not normally added to the test rings.
>
> To address this I have added code that will check for a q_vector before
> returning a napi_id value. If a q_vector is not present it will return a
> value of 0.
>
> Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Thanks Alex!

Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>

I'll look into if this applies to the other Intel drivers as well.


Bj?rn
[...]
