From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 14 Mar 2016 10:12:49 -0700
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Avoid unaligned
 access in ixgbe_atr() for LLC packets
In-Reply-To: <20160314153216.GF5084@oracle.com>
References: <20160314153216.GF5084@oracle.com>
Message-ID: <CAKgT0UfWuv1sui0ZDv3Qy1YnydzBMURF1ptr1XSxz_UE_g=1Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 14, 2016 at 8:32 AM, Sowmini Varadhan
<sowmini.varadhan@oracle.com> wrote:
>
> For LLC based protocols like lldp, stp etc., the ethernet header
> is an 802.3 header with a h_proto that is not 0x800, 0x86dd, or
> even 0x806.  In this world, the skb_network_header() points at
> the DSAP/SSAP/..  and is not likely to be NET_IP_ALIGNed in
> ixgbe_atr().
>
> With LLC, drivers are not likely to correctly find IPVERSION,
> or "6", at hdr.ipv4->version, but will instead just needlessly
> trigger an unaligned access. (IPv4/IPv6 over LLC is almost never
> implemented).
>
> The unaligned access is thus avoidable: bail out quickly after
> examining skb->protocol.
>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 4d6223d..c3885a8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7602,6 +7602,11 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
>  #endif /* CONFIG_IXGBE_VXLAN */
>         }
>
> +       if (skb->protocol != htons(ETH_P_IP) &&
> +           skb->protocol != htons(ETH_P_IPV6) &&
> +           skb->protocol != htons(ETH_P_ARP))
> +               return;
> +

This is disabling too much as it snags VLAN along with everything
else.  Replace skb->protocol with first->protocol and this should work
correctly.

You may also want to move it up by several lines so that you don't
count it as a valid ATR frame via atr_count.

Thanks.

- Alex
