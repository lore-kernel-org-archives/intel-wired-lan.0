From: William Tu <u9012063@gmail.com>
Date: Tue, 2 Oct 2018 11:26:50 -0700
Subject: [Intel-wired-lan] [PATCH v2 5/5] ixgbe: add AF_XDP zero-copy Tx
 support
In-Reply-To: <20181002080034.11754-6-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
 <20181002080034.11754-6-bjorn.topel@gmail.com>
Message-ID: <CALDO+SY20B0q7F2C_A9AO=woukFqCHRe0+hFEYU0beqYfW_O2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 2, 2018 at 1:01 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This patch adds zero-copy Tx support for AF_XDP sockets. It implements
> the ndo_xsk_async_xmit netdev ndo and performs all the Tx logic from a
> NAPI context. This means pulling egress packets from the Tx ring,
> placing the frames on the NIC HW descriptor ring and completing sent
> frames back to the application via the completion ring.
>
> The regular XDP Tx ring is used for AF_XDP as well. This rationale for
> this is as follows: XDP_REDIRECT guarantees mutual exclusion between
> different NAPI contexts based on CPU id. In other words, a netdev can
> XDP_REDIRECT to another netdev with a different NAPI context, since
> the operation is bound to a specific core and each core has its own
> hardware ring.
>
> As the AF_XDP Tx action is running in the same NAPI context and using
> the same ring, it will also be protected from XDP_REDIRECT actions
> with the exact same mechanism.
>
> As with AF_XDP Rx, all AF_XDP Tx specific functions are added to
> ixgbe_xsk.c.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---

Thanks!
Tested-by: William Tu <u9012063@gmail.com>
