From: David Miller <davem@davemloft.net>
Date: Fri, 14 Oct 2016 10:17:30 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH net-next 00/11] net: Fix netdev
	adjacency tracking
In-Reply-To: <1476305519-28833-1-git-send-email-dsa@cumulusnetworks.com>
References: <1476305519-28833-1-git-send-email-dsa@cumulusnetworks.com>
Message-ID: <20161014.101730.404820561372500741.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: David Ahern <dsa@cumulusnetworks.com>
Date: Wed, 12 Oct 2016 13:51:48 -0700

> The netdev adjacency tracking is failing to create proper dependencies
> for some topologies. For example this topology
> 
>         +--------+
>         |  myvrf |
>         +--------+
>           |    |
>           |  +---------+
>           |  | macvlan |
>           |  +---------+
>           |    |
>       +----------+
>       |  bridge  |
>       +----------+
>           |
>       +--------+
>       | bond0  |
>       +--------+
>           |
>       +--------+
>       |  eth3  |
>       +--------+
> 
> hits 1 of 2 problems depending on the order of enslavement. The base set of
> commands for both cases:
> 
>     ip link add bond1 type bond
>     ip link set bond1 up

Your diagram uses the device name "bond0" but all of your command examples
use "bond1".  Please fix this up, thanks.
