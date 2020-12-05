From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 5 Dec 2020 10:00:30 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 6/9] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <20201202045325.3254757-7-vinicius.gomes@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-7-vinicius.gomes@intel.com>
Message-ID: <20201205100030.2e3c5dd2@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue,  1 Dec 2020 20:53:22 -0800 Vinicius Costa Gomes wrote:
> The tc subsystem sets which queues are marked as preemptible, it's the
> role of ethtool to control more hardware specific parameters. These
> parameters include:
> 
>  - enabling the frame preemption hardware: As enabling frame
>  preemption may have other requirements before it can be enabled, it's
>  exposed via the ethtool API;
> 
>  - mininum fragment size multiplier: expressed in usually in the form
>  of (1 + N)*64, this number indicates what's the size of the minimum
>  fragment that can be preempted.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

WARNING: 'PREEMPTABLE' may be misspelled - perhaps 'PREEMPTIBLE'?
