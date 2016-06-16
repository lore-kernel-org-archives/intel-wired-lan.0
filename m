From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date: Fri, 17 Jun 2016 01:06:04 +0200
Subject: [Intel-wired-lan] [net-next PATCH v3 01/17] vxlan/geneve:
 Include udp_tunnel.h in vxlan/geneve.h and fixup includes
In-Reply-To: <20160616192044.20872.17936.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160616192044.20872.17936.stgit@localhost.localdomain>
Message-ID: <4dd0dfc3-bd95-6559-ab53-1cf462d3c914@stressinduktion.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16.06.2016 21:20, Alexander Duyck wrote:
> This patch makes it so that we add udp_tunnel.h to vxlan.h and geneve.h
> header files.  This is useful as I plan to move the generic handlers for
> the port offloads into the udp_tunnel header file and leave the vxlan and
> geneve headers to be a bit more protocol specific.
> 
> I also went through and cleaned out a number of redundant includes that
> where in the .h and .c files for these drivers.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Also,

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>


