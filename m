From: Huy Nguyen <huyn@mellanox.com>
Date: Tue, 23 Jun 2020 11:57:03 -0500
Subject: [Intel-wired-lan] FW: [PATCH net-next v3 4/4] bonding: support
 hardware encryption offload to slaves
In-Reply-To: <AM0PR05MB5250242D3F80160817117F60C4940@AM0PR05MB5250.eurprd05.prod.outlook.com>
References: <20200619143155.20726-1-jarod@redhat.com>
 <20200619143155.20726-5-jarod@redhat.com>
 <AM0PR05MB5250242D3F80160817117F60C4940@AM0PR05MB5250.eurprd05.prod.outlook.com>
Message-ID: <b6c69a4b-3db7-b840-085d-883b6775865f@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> +#ifdef CONFIG_XFRM_OFFLOAD
> +	struct xfrm_state *xs;
We must support more than one SA right?

