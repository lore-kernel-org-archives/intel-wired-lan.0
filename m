From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 Nov 2015 14:57:20 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Clean up redundancy in
	hw_enc_features
In-Reply-To: <20151118211020.124539.53305.stgit@mdrustad-wks.jf.intel.com>
References: <20151118211020.124539.53305.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <CAKgT0UfeGNiO0WjfKaHYz+_P+9Gg2is5w1QT7HwSdoTbk-Ezdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Nov 18, 2015 at 1:10 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> Clean up minor redundancy in the setting of hw_enc_features that
> makes it appears that X550 uniquely has more encapsulation features
> than other devices. The driver only supports one more feature, so
> make it look that way. Also change the initial assignment to
> hw_enc_features to be a simple assignment, just to be clearer about
> that as well. Thanks to Alex Duyck for noticing this slight confusion.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 4ef5b63b2543..66701ec96359 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9015,8 +9015,8 @@ skip_sriov:
>         netdev->vlan_features |= NETIF_F_IPV6_CSUM;
>         netdev->vlan_features |= NETIF_F_SG;
>
> -       netdev->hw_enc_features |= NETIF_F_SG | NETIF_F_IP_CSUM |
> -                                  NETIF_F_IPV6_CSUM;
> +       netdev->hw_enc_features = NETIF_F_SG | NETIF_F_IP_CSUM |
> +                                 NETIF_F_IPV6_CSUM;

This can probably be left as an "|=" instead of just being an "=".
That way if a flag is set in the future as a part of allocating the
netdev or anything like that you are adding your flags instead of
overwriting any existing ones.  In addition there is no need to set
the NETIF_F_SG bit as that gets set by register_netdevice via the
register_netdev call.

Thanks.

- Alex
