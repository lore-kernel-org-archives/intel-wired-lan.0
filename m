From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Mon, 28 Oct 2019 15:02:12 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: implement VF stats
 NDO
In-Reply-To: <20191028183714.50528-1-jesse.brandeburg@intel.com>
References: <20191028183714.50528-1-jesse.brandeburg@intel.com>
Message-ID: <CAP-MU4PtF0eJuuihH6VQ12RDak=Vrn8oYPitqU7Z10pD3YcM_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 28, 2019 at 11:37 AM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Implement the VF stats gathering via the kernel via ndo_get_vf_stats().
> The driver will show per-VF stats in the output of the
> ip -s link show dev <PF>
> command.
>
> Testing Hints (Required if no HSD): ip -s link show dev eth0,
> will return non-zero VF stats.

Oh, I remember the "HSD" acronym... but it isn't needed in an external patch.

>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---

[...]

> +       vf_stats->rx_packets = stats->rx_unicast + stats->rx_broadcast +
> +               stats->rx_multicast;
> +       vf_stats->tx_packets = stats->tx_unicast + stats->tx_broadcast +
> +               stats->tx_multicast;
> +       vf_stats->rx_bytes   = stats->rx_bytes;
> +       vf_stats->tx_bytes   = stats->tx_bytes;
> +       vf_stats->broadcast  = stats->rx_broadcast + stats->tx_broadcast;
> +       vf_stats->multicast  = stats->rx_multicast + stats->tx_multicast;

Are you sure these are supposed to count up both Tx and Rx multicast
and broadcast?  With a quick peek at VF stats output from "ip -s link"
I see that only the Rx line mcast and bcast, the Tx line does not.  I
would infer that we're only counting what has been received.

    vf 0 MAC 00:00:00:00:00:00, spoof checking off, link-state auto, trust off
    RX: bytes  packets  mcast   bcast
    0          0        0       0
    TX: bytes  packets
    0          0

I suspect there's a definition somewhere, but I haven't stumbled
across it recently.

(yes, I still occasionally read these patches)

sln
