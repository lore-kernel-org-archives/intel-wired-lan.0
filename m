From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 5 Dec 2020 09:59:48 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 8/9] igc: Add support for
 exposing frame preemption stats registers
In-Reply-To: <20201202045325.3254757-9-vinicius.gomes@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-9-vinicius.gomes@intel.com>
Message-ID: <20201205095948.5e0eba28@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Dec 2020 20:53:24 -0800 Vinicius Costa Gomes wrote:
> Expose the Frame Preemption counters, so the number of
> express/preemptible packets can be monitored by userspace.
> 
> These registers are cleared when read, so the value shown is the
> number of events that happened since the last read.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

You mean expose in a register dump? That's not great user experience..

Are there any stats that the standards mandate?

It'd be great if we could come up with some common set and expose them
via ethtool like the pause frame statistics.
