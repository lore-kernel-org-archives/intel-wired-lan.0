From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Wed, 14 Aug 2019 07:46:51 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v4 1/8] xsk: replace
 ndo_xsk_async_xmit with ndo_xsk_wakeup
In-Reply-To: <1565767643-4908-2-git-send-email-magnus.karlsson@intel.com>
References: <1565767643-4908-1-git-send-email-magnus.karlsson@intel.com>
 <1565767643-4908-2-git-send-email-magnus.karlsson@intel.com>
Message-ID: <B49497F3-8DD7-4C24-B7EE-CBF3488A913C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 14 Aug 2019, at 0:27, Magnus Karlsson wrote:

> This commit replaces ndo_xsk_async_xmit with ndo_xsk_wakeup. This new
> ndo provides the same functionality as before but with the addition of
> a new flags field that is used to specifiy if Rx, Tx or both should be
> woken up. The previous ndo only woke up Tx, as implied by the
> name. The i40e and ixgbe drivers (which are all the supported ones)
> are updated with this new interface.
>
> This new ndo will be used by the new need_wakeup functionality of XDP
> sockets that need to be able to wake up both Rx and Tx driver
> processing.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
