From: Hannes Frederic Sowa <hsowa@redhat.com>
Date: Fri, 17 Jun 2016 00:59:53 +0200
Subject: [Intel-wired-lan] [net-next PATCH v3 16/17] net: Remove
 deprecated tunnel specific UDP offload functions
In-Reply-To: <20160616192312.20872.19285.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160616192312.20872.19285.stgit@localhost.localdomain>
Message-ID: <b1786c31-f09e-104d-0410-d4f85bbe85b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16.06.2016 21:23, Alexander Duyck wrote:
> Now that we have all the drivers using udp_tunnel_get_rx_ports,
> ndo_add_udp_enc_rx_port, and ndo_del_udp_enc_rx_port we can drop the
> function calls that were specific to VXLAN and GENEVE.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>

Also thanks for cleaning the Kconfig dust from all the drivers!


