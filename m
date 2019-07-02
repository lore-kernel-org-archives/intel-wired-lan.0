From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Tue, 2 Jul 2019 11:42:52 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v2 1/6] xsk: replace
 ndo_xsk_async_xmit with ndo_xsk_wakeup
In-Reply-To: <1562059288-26773-2-git-send-email-magnus.karlsson@intel.com>
References: <1562059288-26773-1-git-send-email-magnus.karlsson@intel.com>
 <1562059288-26773-2-git-send-email-magnus.karlsson@intel.com>
Message-ID: <a57b5b49-bd03-92af-cc5d-fe11d1d0e437@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-02 12:21, Magnus Karlsson wrote:
> This commit replaces ndo_xsk_async_xmit with ndo_xsk_wakeup. This new
> ndo provides the same functionality as before but with the addition of
> a new flags field that is used to specifiy if Rx, Tx or both should be
> woken up. The previous ndo only woke up Tx, as implied by the
> name. The i40e and ixgbe drivers (which are all the supported ones)
> are updated with this new interface.

This API change will break build of mlx5 - XSK support for mlx5 was merged.

> This new ndo will be used by the new need_wakeup functionality of XDP
> sockets that need to be able to wake up both Rx and Tx driver
> processing.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

