From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 23 May 2022 23:33:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 00/11] ethtool: Add
 support for frame preemption
In-Reply-To: <20220523125238.6f73b9f5@kernel.org>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
 <20220520153413.16c6830b@kernel.org> <20220521150304.3lhpraxpssjxfhai@skbuf>
 <20220523125238.6f73b9f5@kernel.org>
Message-ID: <20220523233338.tmwykgwutoigurnu@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, May 23, 2022 at 12:52:38PM -0700, Jakub Kicinski wrote:
> My understanding is that DCBNL is not in ethtool is that it was built
> primarily for converged Ethernet. ethtool being a netdev thing it's
> largely confined to coarse interface configuration in such
> environments, they certainly don't use TC to control RDMA queues.
> 
> To put it differently DCBNL separates RoCE and storage queues from
> netdev queues (latter being lossy). It's Conway's law at work.

I had to look up Conway's law, now I get it. Beautiful euphemism, thank you.
